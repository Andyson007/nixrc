{ ... }: {
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    settings = {

      profile.name = "mobile";
      profile.outputs = [
        {
          criteria = "eDP-1";
          status = "enable";
        }
      ];
      
      profile.name = "docked";
      profile.outputs = [
        {
          criteria = "eDP-1";
          status = "disable";
        }
        {
          criteria = "*";
          status = "enable";
          position = "0,0";
        }
      ];
      
    };
  };
}
