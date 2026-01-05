package internal

import (
	"errors"
	"fmt"
	"log"
	"os"
)

type Args struct {
	Login *struct{}  `arg:"subcommand:login" help:"open tailscale's oauth token generation page"`
	Token *TokenArgs `arg:"subcommand:token" help:"token manipulation commands"`
}

type TokenArgs struct {
	NewCmd   *struct{} `arg:"subcommand:new" help:"issue a new authentication token"`
	RenewCmd *struct{} `arg:"subcommand:renew" help:"renew an authentication token"`

	Dir         string `arg:"-d,--dir" help:"directory to output the token and metadata to"`
	Credentials string `arg:"-c,--credentials" help:"file with credentials to connect to the tailscale api"`
}

func (a *Args) Default() {
	var token TokenArgs
	token.Default()

	a.Token = &token
}

func (a *TokenArgs) Default() {
	dir, err := os.Getwd()
	if err != nil {
		log.Panic("failed to resolve pwd", err)
	}

	a.Dir = dir
}

func (a *Args) Run() error {
	if a.Login != nil {
		return Login()
	} else if a.Token != nil {
		return a.Token.Run()
	}

	return errors.New("no suitable command")
}

func (a *TokenArgs) Run() error {
	var (
		config ClientConfig
		err    error
	)

	if len(a.Credentials) > 0 {
		config, err = NewConfigFromFile(a.Credentials)
	} else {
		config, err = NewConfigFromEnv()
	}

	if err != nil {
		return fmt.Errorf("could not create API client: %w", err)
	}

	client := NewAPIClient(config)
	if a.NewCmd != nil {
		return NewToken(client, a.Dir)
	} else if a.RenewCmd != nil {
		return RenewToken(client, a.Dir)
	}

	return errors.New("no suitable command")
}
