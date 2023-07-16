{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  security.pam.services.swaylock = { };

  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  environment.systemPackages = with pkgs; [
    polkit_gnome
  ];

  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
  };
}
