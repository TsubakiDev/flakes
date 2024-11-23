{ pkgs, ... }:
{
  # Bootloader.
  boot = {
    # Use latest linux-xanmod kernel.
    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };
      efi.canTouchEfiVariables = true;
    };

    # Add support for NTFS
    supportedFilesystems = [ "ntfs" ];

    tmp = {
      useTmpfs = true;
      tmpfsSize = "80%";
    };
  };
}
