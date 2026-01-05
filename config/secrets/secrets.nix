let
  vasco = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOhkfgFv8yH7Td4QMadLFDCgMrXpI7QQaMNBM2YeN/+k";
  sunny = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBjqtJ2S0g320DRRcufPHceTHZVn/8WKRDtJPENouqUg
";
in {
  "wireguard.age".publicKeys = [vasco];
  "ovh.age".publicKeys = [vasco sunny];
}
