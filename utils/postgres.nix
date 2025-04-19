{
  pkgs,
  lib,
  config,
  ...
}: {
  options.postgres = let
    inherit (lib) mkOption types;
  in {
    extraAuth = mkOption {
      type = types.listOf types.str;
      default = [];
      apply = lib.concatLines;
      example = "";
    };
  };
  config = {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_16;
      settings.ssl = true;
      authentication =
        ''
          #type database           DBuser  auth-method
          local all                all     trust
        ''
        + config.postgres.extraAuth;
    };
  };
}
