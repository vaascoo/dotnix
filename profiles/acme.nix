{
  config,
  pkgs,
  ...
}: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "self@vaascoo.pt";

    certs."vaascoo.pt" = {
      domain = "vaascoo.pt";
      extraDomainNames = ["*.vaascoo.pt"];
      dnsProvider = "ovh";
      dnsPropagationCheck = true;
      credentialsFile = config.age.secrets.ovhCreds.path;
    };
  };
}
