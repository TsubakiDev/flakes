{ pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      maple-mono
      noto-fonts
      noto-fonts-cjk-sans
    ];
  };
}
