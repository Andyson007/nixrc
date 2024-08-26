{pkgs, ...}: {
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    settings = [
      {
        profile = {
          name = "docked_home";
          outputs = [
            {
              criteria = "eDP-1";
              position = "1300,1200";
              scale = 1.2;
              status = "enable";
            }
            {
              criteria = "Dell Inc. DELL U2410 F525M27UD0DL";
              mode = "1920x1200@59.95";
              position = "0,0";
              scale = 1.0;
              status = "enable";
            }
            {
              criteria = "Dell Inc. DELL U2410 F525M29HC43L";
              mode = "1920x1200@59.95";
              position = "1920,0";
              scale = 1.0;
              status = "enable";
            }
          ];
          exec = "~/.config/kanshi/docked_home";
        };
      }
      {
        profile = {
          name = "undocked";
          outputs = [
            {
              criteria = "eDP-1";
              scale = 1.2;
              status = "enable";
            }
          ];
          exec = "~/.config/kanshi/undocked";
        };
      }
      {
        profile = {
          name = "docked_tv";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "Samsung Electric Company SAMSUNG 0x01000E00";
              scale = 2.0;
              status = "enable";
            }
          ];
          exec = "~/.config/kanshi/docked_tv";
        };
      }
      {
        profile = {
          name = "docked_school";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
              scale = 1.2;
            }
            {
              criteria = "DUS D27QO 0x00000001";
              scale = 1.0;
              status = "enable";
            }
          ];
          exec = "~/.config/kanshi/docked_school";
        };
      }
    ];
  };
  home.file = {
    ".config/kanshi/docked_home" = {
      text = ''
        ${pkgs.hyprland}/bin/hyprctl --batch dispatch "\
        workspace 1,monitor:eDP-1,                                  on-created-empty: alacritty;\
        keyword workspace 2,monitor:eDP-1,                                  on-created-empty: alacritty;\
        keyword workspace 3,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL;\
        keyword workspace 4,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL;\
        keyword workspace 5,monitor:desc:Dell Inc. DELL U2410 F525M29HC43L, on-created-empty: firefox;\
        keyword workspace 6,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL, on-created-empty: obsidian;\
        keyword workspace 7,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL, on-created-empty: spotify;\
        keyword workspace 8,monitor:eDP-1;\
        keyword workspace 9,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL, on-created-empty: discord;\
        keyword workspace 10,monitor:eDP-1"
      '';
      executable = true;
    };
    ".config/kanshi/undocked" = {
      text = ''
          ${pkgs.hyprland}/bin/hyprctl --batch dispatch "\
        workspace 1,monitor:eDP-1, on-created-empty: alacritty;\
        keyword workspace 2,monitor:eDP-1, on-created-empty: alacritty;\
        keyword workspace 3,monitor:eDP-1;\
        keyword workspace 4,monitor:eDP-1;\
        keyword workspace 5,monitor:eDP-1, on-created-empty: firefox;\
        keyword workspace 6,monitor:eDP-1, on-created-empty: obsidian;\
        keyword workspace 7,monitor:eDP-1, on-created-empty: spotify;\
        keyword workspace 8,monitor:eDP-1;\
        keyword workspace 9,monitor:eDP-1, on-created-empty: discord;\
        keyword workspace 10,monitor:eDP-1"
      '';
      executable = true;
    };
    ".config/kanshi/docked_tv" = {
      text = ''
          ${pkgs.hyprland}/bin/hyprctl --batch dispatch "\
        workspace 1,monitor:desc: Samsung Electric Company SAMSUNG 0x01000E00, on-created-empty: alacritty;\
        keyword workspace 2,monitor:desc: Samsung Electric Company SAMSUNG 0x01000E00, on-created-empty: alacritty;\
        keyword workspace 3,monitor:desc: Samsung Electric Company SAMSUNG 0x01000E00;\
        keyword workspace 4,monitor:desc: Samsung Electric Company SAMSUNG 0x01000E00;\
        keyword workspace 5,monitor:desc: Samsung Electric Company SAMSUNG 0x01000E00, on-created-empty: firefox;\
        keyword workspace 6,monitor:desc: Samsung Electric Company SAMSUNG 0x01000E00, on-created-empty: obsidian;\
        keyword workspace 7,monitor:desc: Samsung Electric Company SAMSUNG 0x01000E00, on-created-empty: spotify;\
        keyword workspace 8,monitor:desc: Samsung Electric Company SAMSUNG 0x01000E00;\
        keyword workspace 9,monitor:desc: Samsung Electric Company SAMSUNG 0x01000E00, on-created-empty: discord;\
        keyword workspace 10,monitor:desc: Samsung Electric Company SAMSUNG 0x01000E00"
      '';
      executable = true;
    };
    ".config/kanshi/docked_school" = {
      text = ''
          ${pkgs.hyprland}/bin/hyprctl --batch dispatch "\
        workspace 1,monitor:desc:DUS D27QO 0x00000001 , on-created-empty: alacritty;\
        keyword workspace 2,monitor:eDP-1, on-created-empty: alacritty;\
        keyword workspace 3,monitor:eDP-1;\
        keyword workspace 4,monitor:eDP-1;\
        keyword workspace 5,monitor:desc: DUS D27QO 0x00000001, on-created-empty: firefox;\
        keyword workspace 6,monitor:desc: DUS D27QO 0x00000001, on-created-empty: obsidian;\
        keyword workspace 7,monitor:desc: DUS D27QO 0x00000001, on-created-empty: spotify;\
        keyword workspace 8,monitor:desc: eDP-1;\
        keyword workspace 9,monitor:desc: DUS D27QO 0x00000001, on-created-empty: discord;\
        keyword workspace 10,monitor:desc: eDP-1"
      '';
      executable = true;
    };
  };
}
