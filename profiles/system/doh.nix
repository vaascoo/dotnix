{
  pkgs,
  lib,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    dnsutils
    dogdns
  ];

  networking.networkmanager = lib.mkIf config.networking.networkmanager.enable {
    dns = "none";
  };

  networking.nameservers = [
    "127.0.0.1"
  ];

  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
      ipv4_servers = true;
      ipv6_servers = true;
      dnscrypt_servers = true;
      doh_servers = true;
      odoh_servers = false;
      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;
      server_names = [
        "cloudflare"
        "adguard-dns"
        "adguard-dns-doh"
        "controld-unfiltered"
        "mullvad-adblock-doh"
        "mullvad-doh"
        "nextdns"
      ];
    };
  };
}
