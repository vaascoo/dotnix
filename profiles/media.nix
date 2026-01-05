{...}: {
  #TODO this will be moved from here
  users.groups.media = {};
  users.users.media = {
    isSystemUser = true;
    group = "media";
    extraGroups = ["media"];
  };
}
