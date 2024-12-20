{
  lib,
  config,
  ...
}: {
  options.virt-manager = let
    inherit (lib) mkOption types;
  in {
    username = mkOption {
      type = types.str;
      default = "andy";
      example = "andy";
    };
  };
  config = {
    programs.virt-manager.enable = true;
    users.groups.libvrtd.members = [config.virt-manager.username];
    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };
  };
}
