{ pkgs, ... }:

{
  programs.npm.enable = true;

  environment.systemPackages = with pkgs; [
    nodejs
    yarn
    deno
  ];
}
