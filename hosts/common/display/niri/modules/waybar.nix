{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar.layer = "top";
    };
  };
}
