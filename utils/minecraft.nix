{
  pkgs,
  lib,
  ...
}: {
  services.minecraft = {
    enable = true;
    eula = true;
  };
}
