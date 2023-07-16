{ pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      auto-optimise-store = true;
      substituters = lib.mkForce [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.cernet.edu.cn/nix-channels/store"
        "https://mirrors.bfsu.edu.cn/nix-channels/store"
        "${rp}https://cache.nixos.org"
        "${rp}https://rewine.cachix.org"
        "${rp}https://xddxdd.cachix.org"
        "${rp}https://cache.garnix.io"
      ];
    };
  };
}
