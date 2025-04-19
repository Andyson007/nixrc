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
          #type database  DBuser  auth-method
          local all       all     trust
          host  all       all     127.0.0.1/32 scram-sha-256
          host  all       all     ::1/128 scram-sha-256
        ''
        + config.postgres.extraAuth;
    };
  };
}
