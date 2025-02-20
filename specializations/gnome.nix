{ pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;

    desktopManager = {
      gnome.enable = true;
    };

    displayManager = {
      gdm.enable = true;

      autoLogin = {
        enable = true;
        user = "user";
      };
    };

    excludePackages = [ pkgs.xterm ];
  };

  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };

  environment.gnome.excludePackages = [ pkgs.gnome-tour ];

  hardware.pulseaudio.enable = false;
  programs.hyprland.enable = lib.mkForce false;
  services.greetd.enable = lib.mkForce false;
}
