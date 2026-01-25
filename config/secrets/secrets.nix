let
  vasco = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILMw/MbYbMQUeNcdXAqBZ18IsmU8+rJGpjTP0NL3OprD";
  cloudy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGLtTU8FY5jAHOiTPLYCYuWnBq9ZOsd33qZhDuLfSUpd";
in {
  "ovh.age".publicKeys = [vasco cloudy];
  "authelia.jwt.age".publicKeys = [vasco cloudy];
  "authelia.key.age".publicKeys = [vasco cloudy];
  "wpa_supplicant.conf.age".publicKeys = [vasco cloudy];
}
