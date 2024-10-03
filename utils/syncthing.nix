{pkgs, ...}: {
  services.syncthing = {
    enable = true;
    user = "andy";
    dataDir = "/home/andy/Documents/";
    configDir = "/home/andy/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
  };
  environment.systemPackages = [
    pkgs.syncthing
  ];
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
  networking.firewall.allowedUDPPorts = [22000 21027];
}
