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
            mode = "1920x1080@60.01";
            position = "1300x1200";
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
