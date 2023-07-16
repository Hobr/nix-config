{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [{
      home.stateVersion = "23.05";
    }];

    users = {
      user = {
        home.username = "user";
        home.homeDirectory = "/home/user";
      };
    };
  };
}
