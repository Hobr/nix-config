{ pkgs, ... }:

{
  imports = [
    ./overlays
    ./modules/zsh.nix
    ./modules/fonts.nix
    ./modules/home-manager.nix
    ./modules/locale.nix
    ./modules/neovim.nix
    ./modules/nix.nix
    ./modules/starship.nix
    ./modules/stylix.nix
    ./modules/timezone.nix
  ];

  home-manager.sharedModules = [
    ./home/gtk.nix
    ./home/htop.nix
    ./home/joshuto.nix
    ./home/kitty.nix
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
      XCURSOR_SIZE = "24";
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      GLFW_IM_MODULE = "ibus";
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
  hardware.opengl.enable = true;

  system.stateVersion = "23.05";
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
