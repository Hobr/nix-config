{ home-manager, stylix, ... }:

{
  imports = [
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
    ./hardware
    ./home
    ./modules
    ./overlays
  ];
}
