{ pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      maple-mono-NF
      noto-fonts
      noto-fonts-cjk-sans
    ];
  };
}
