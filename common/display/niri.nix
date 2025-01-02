{ ... }:
{
  imports = [
    ./waybar.nix
  ];

  programs.niri = {
    enable = true;
  };
}