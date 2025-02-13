{ config, ... }:
{
  services.cloudflared = {
    enable = true;
    tunnels = {
      "00000000-0000-0000-0000-000000000000" = {
        credentialsFile = "${config.sops.secrets.cloudflared-creds.path}";
        ingress = {
          "code.tsubaki.dev" = "http://localhost:80";
        };
        default = "http_status:404";
      };
    };
  };
}