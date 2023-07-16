{
  users = {
    mutableUsers = false;

    users = {
      hobr = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
      };
    };
  };
}
