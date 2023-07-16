{ pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;

    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      auto-optimise-store = true;
      substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
    };
  };
}
