{ pkgs, ... }:

{
  imports = [
    ./modules/fonts.nix
    ./modules/stylix.nix
    ./modules/home-manager.nix
  ];

  home-manager.sharedModules = [
    ./home/gtk.nix
    ./home/xcursor.nix
    ./home/xresources.nix
  ];

  environment = {
    defaultPackages = [ ];
    variables.TERM = "xterm-kitty";

    sessionVariables = {
      WAYLAND_DISPLAY = "wayland-1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_RUNTIME_DIR = "/run/user/1000";
      DISPLAY = ":0";
    };
  };

  environment.systemPackages = with pkgs; [
    kitty
  ];

  users = {
    mutableUsers = false;
    allowNoPasswordLogin = true;

    users = {
      user = {
        isNormalUser = true;
        home = "/home/user";
      };
    };
  };

  services.xserver.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  system.stateVersion = "22.11";
}
