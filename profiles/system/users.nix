{pkgs, ...}: {
  users.mutableUsers = false;
  users.users = {
    vasco = {
      isNormalUser = true;
      description = "Vasco Correia";
      extraGroups = ["wheel" "networkmanager"];
      initialHashedPassword = "$6$DzeNGzM3T9/NALiy$iHZ.pTMGbqhdMzcpwTuZ8dM6zGGoH.7M/m5GBAK5v3tdg2rpYcnSq8k3VlEwsvbOjv/fcK2BR7E8yt69nE9BR/";
      shell = pkgs.fish;
    };
    # TODO(vaascoo): add this to age
    root.initialHashedPassword = "$6$3JxKzQC6CWN0Xpuk$RQsbyj5s4jb3EY8deMNtoClypHCQXJkSbDtQ/KxVEQ6qhxxP4g9iXDxkTmH28tsWPm6kkDlg1ae34f.amWUVs0";
  };
}
