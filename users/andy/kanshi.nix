{ ... }: 
{
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    settings = [
      {
        profile.name = "docked_home";
        profile.outputs = [
          {
            criteria = "eDP-1";
            position = "1300,1200";
            scale = 1.2;
            status = "enable";
          }
          {
            criteria = "Dell Inc. DELL U2410 F525M29HC43L";
            mode = "1920x1200@59.95";
            position = "0,0";
            scale = 1.0;
            status = "enable";
          }
          {
            criteria = "Dell Inc. DELL U2410 F525M27UD0DL";
            mode = "1920x1200@59.95";
            position = "1920,0";
            scale = 1.0;
            status = "enable";
          }
        ];
      }
      { 
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            scale = 1.0;
            status = "enable";
          }
        ];
      }
    ];
  };
}
