{
  ...
}:
{
  imports = [
    ./configuration.nix
    ./hardware.nix
  ];

  hardware.graphics.enable32Bit = true;
}