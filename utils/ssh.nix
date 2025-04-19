{...}: {
  config = {
    services.openssh = {
      enable = true;
      settings.passwordAuthentication = false;
    };
    networking.firewall.allowedTCPPorts = [22];
  };
}
