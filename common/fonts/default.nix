{ pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      maple-font
      noto-fonts
      noto-fonts-cjk-sans
    ];
  };
}
