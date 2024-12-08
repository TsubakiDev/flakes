{ pkgs, ... }:
{
  services.mihomo = {
    enable = true;
    webui = pkgs.metacubexd;
  };
}