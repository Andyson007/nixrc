{
  lib,
  config,
  pkgs,
  ...
}: {
  options.virt-manager = let
    inherit (lib) mkOption types;
  in {
    username = mkOption {
      type = types.str;
      example = "andy";
    };
  };
  config = {
    programs.virt-manager.enable = true;
    environment.systemPackages = [
      pkgs.virt-viewer
    ];
    users.groups.libvrtd.members = [config.virt-manager.username];
    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };
  };
}
