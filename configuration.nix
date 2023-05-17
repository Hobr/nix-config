{ config, pkgs, lib, stylix, ... }:

{
  imports = [
    ./laptop.nix
    ./modules/starship.nix
    ./modules/fish.nix
    ./modules/fonts.nix
    ./modules/stylix
    ./modules/htop.nix
    ./modules/dual-function-keys.nix
    ./modules/tlp.nix
    ./modules/osu
    ./modules/srb2
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.displayManager.lightdm.enable = false;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];
  networking.networkmanager.dns = "none";
  networking.useHostResolvConf = true;

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
    };
    virtualisation.qemu.options =
      [ "-device virtio-vga-gl" "-display sdl,gl=on" ];

    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.displayManager.gdm.enable = true;

    i18n.inputMethod = lib.mkDefault {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ mozc ];
    };

    services.gnome.core-utilities.enable = false;
    environment.gnome.excludePackages = [ pkgs.gnome-tour ];
    hardware.pulseaudio.enable = false;
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_DISCOVERY_ACROSS_FILESYSTEM = "1";
    FZF_DEFAULT_OPTS = "--height 40% --reverse --border --color=16";
    NODE_OPTIONS = "--max_old_space_size=16384";
  };

  services.vnstat.enable = true;
  services.tumbler.enable = true;
  security.rtkit.enable = true;

  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales =
    [ "en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8" ];

  services.xserver.enable = true;

  programs.firejail.enable = true;
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    pinentry-curses
    wget
    grim
    slurp
    mullvad-vpn
    mullvad-browser
    papirus-icon-theme
    mediainfo
    pywal
    mpc-cli
    neofetch
    tectonic
    fdupes
    anki
    logseq
    yt-dlp
    gurk-rs
    wl-clipboard
    ffmpeg
    siege
    ponysay
    lolcat
    figlet
    calcurse
    httpie
    cmatrix
    sox
    spek
    p7zip
    ripgrep
    rsync
    jq
    keepassxc
    stow
    exa
    fd
    fzf
    unar
    audacity
    gimp
    typespeed
    slade
    gdu
    ranger
    nixfmt
    whois
    lnch
    libnotify
    dwt1-shell-color-scripts
    dig
    trashy
    swaybg
    udiskie
    brightnessctl
    killall
    nodejs
    yarn
    deno
    crystal
    shards
    rustc
    rustfmt
    cargo
    genact
    (pkgs.callPackage ./pkgs/srb2.nix {})
  ];

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.enableExcludeWrapper = false;
  networking.networkmanager.wifi.macAddress = "random";
  networking.networkmanager.ethernet.macAddress = "random";
  services.resolved.llmnr = "false";

  environment.defaultPackages = [ ];
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Force containers to use mullvad
  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-+" ];
  networking.nat.externalInterface = "wg-mullvad";

  system.stateVersion = "22.11";
}
