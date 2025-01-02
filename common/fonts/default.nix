{ pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      MapleMono-ttf
      noto-fonts
      noto-fonts-cjk-sans
    ];
  };
}
