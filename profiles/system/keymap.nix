{
  ...
}: {
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.xkb.layout = "us";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
}
