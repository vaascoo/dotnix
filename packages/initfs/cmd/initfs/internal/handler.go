package internal

import (
	"context"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"maps"
	"os"
	"os/exec"
	"path"
	"time"

	"tailscale.com/client/tailscale/v2"
)

const URL = "https://login.tailscale.com/admin/settings/trust-credentials/add"

func Login() error {
	log.Printf("opening %s on the user's predefined browser\n", URL)

	cmd := exec.Command("xdg-open", URL)
	if err := cmd.Run(); err != nil {
		return fmt.Errorf("error running command: %w", err)
	}

	return nil
}

type ClientConfig struct {
	TailscaleNetID     string `json:"tailnetID"`
	TailscaleClientID  string `json:"clientID"`
	TailscaleClientKey string `json:"clientKey"`
}

func NewConfigFromFile(path string) (config ClientConfig, err error) {
	file, err := os.Open(path)	
	if err != nil {
		err = fmt.Errorf("error opening credentials file '%s': %w", path, err)
		return
	}
	defer file.Close()

	err = json.NewDecoder(file).Decode(&config)
	log.Println("credentials read from file", path)
	return
}

func NewConfigFromEnv() (config ClientConfig, err error) {
	var (
		envVar string
		ref *string
		exists bool
		vars   = map[string]*string{
			"TAILSCALE_NET_ID":     &config.TailscaleNetID,
			"TAILSCALE_CLIENT_ID":  &config.TailscaleClientID,
			"TAILSCALE_CLIENT_KEY": &config.TailscaleClientKey,
		}
	)

	log.Println("creating API client from env", maps.Keys(vars))

	defer func() {
		if !exists {
			err = fmt.Errorf("'%s' env var is not set", envVar)
		}
	}()

	for envVar, ref = range vars {
		var value string
		value, exists = os.LookupEnv(envVar)
		if !exists {
			return
		}
		*ref = value
	}
	return
}

func NewAPIClient(config ClientConfig) *tailscale.Client {
	return &tailscale.Client{
		Auth: &tailscale.OAuth{
			ClientID:     config.TailscaleClientID,
			ClientSecret: config.TailscaleClientKey,
			Scopes:       []string{"auth_keys"},
		},
		Tailnet: config.TailscaleNetID,
	}
}

func NewToken(client *tailscale.Client, dir string) error {
	var (
		tokenFile = path.Join(dir, "token")
		metadataFile = path.Join(dir, "metadata.json")
	)

	token, err := fetchToken(client)
	if err != nil {
		return fmt.Errorf("error generating token: %w", err)
	}

	out := outputFile(tokenFile)
	defer out.Close()

	metaOut := outputFile(metadataFile)
	defer metaOut.Close()

	log.Println("saving token", tokenFile)
	if err := saveToken(token, out); err != nil {
		return fmt.Errorf("error saving token: %w", err)
	}

	log.Println("saving metadata", metadataFile)
	if err := saveMetadata(token, metaOut); err != nil {
		return fmt.Errorf("error saving metadata: %w", err)
	}

	return nil
}

func saveToken(token *tailscale.Key, w io.Writer) error {
	_, err := w.Write([]byte(token.Key))
	if err != nil {
		return fmt.Errorf("error writing token: %w", err)
	}

	return nil
}

func saveMetadata(token *tailscale.Key, w io.Writer) error {
	encoder := json.NewEncoder(w)
	if err := encoder.Encode(token); err != nil {
		return fmt.Errorf("error writing metadata: %w", err)
	}

	return nil
}

func outputFile(path string) *os.File {
	file, err := os.OpenFile(path, os.O_CREATE | os.O_TRUNC | os.O_WRONLY, 0o600)
	if err != nil {
		log.Panic("error opening output file", path, err.Error())
	}

	return file
}

func fetchToken(client *tailscale.Client) (*tailscale.Key, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	key, err := client.Keys().Create(ctx, tailscale.CreateKeyRequest{
		Capabilities: tailscale.KeyCapabilities{
			Devices: struct {
				Create struct {
					Reusable      bool     "json:\"reusable\""
					Ephemeral     bool     "json:\"ephemeral\""
					Tags          []string "json:\"tags\""
					Preauthorized bool     "json:\"preauthorized\""
				} "json:\"create\""
			}{
				Create: struct {
					Reusable      bool     "json:\"reusable\""
					Ephemeral     bool     "json:\"ephemeral\""
					Tags          []string "json:\"tags\""
					Preauthorized bool     "json:\"preauthorized\""
				}{
					Reusable:  true,
					Ephemeral: true,
					Tags: []string{
						"tag:initrd",
					},
					Preauthorized: true,
				},
			},
		},
	})
	if err != nil {
		return nil, fmt.Errorf("error creating new auth token: %w", err)
	}

	obfuscatedKey := *key
	obfuscatedKey.Key = "omitted"
	log.Printf("generated key: %+v\n", obfuscatedKey)

	return key, nil
}


func RenewToken(client *tailscale.Client, dir string) error {
	var metadataFile = path.Join(dir, "metadata.json")
	file, err := os.Open(metadataFile)
	if err != nil {
		return fmt.Errorf("error opening file: %w", err)
	}
	defer file.Close()

	var key tailscale.Key
	if err := json.NewDecoder(file).Decode(&key); err != nil {
		return fmt.Errorf("error decoding key metadata: %w", err)
	}

	const day = 24 * time.Hour
	if time.Now().Add(30 * day).Before(key.Expires) {
		/*
										now() + 30
		now() ----------------|
										|-----------expires
		*/
		log.Println("key valid until", key.Expires)
		return nil
	}

	// pass through to generate new token
	return NewToken(client, dir)
}
