{ pkgs, ... }: 
{
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
              scale = 1.0;
              status = "enable";
            }
          ];
          exec = "~/.config/kanshi/undocked";
        };
      }
    ];
  };
  home.file = {
      ".config/kanshi/docked_home" = {
        text = ''
    ${pkgs.hyprland}/bin/hyprctl --batch dispatch "\
    workspace 1,monitor:eDP-1,                                  on-created-empty: alacritty;\
    workspace 2,monitor:eDP-1,                                  on-created-empty: alacritty;\
    workspace 3,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL;\
    workspace 4,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL;\
    workspace 5,monitor:desc:Dell Inc. DELL U2410 F525M29HC43L, on-created-empty: firefox;\
    workspace 6,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL, on-created-empty: obsidian;\
    workspace 7,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL, on-created-empty: spotify;\
    workspace 8,monitor:eDP-1,                                  on-created-empty: \"${pkgs.neovide}/bin/neovide -- --cmd 'cd ~/vaults/Knowledge/'\";\
    workspace 9,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL, on-created-empty: discord;\
    workspace 10,monitor:eDP-1"
      '';
      executable = true;
    };
    ".config/kanshi/undocked" = {
        text = ''
      ${pkgs.hyprland}/bin/hyprctl --batch dispatch "\
    workspace 1,monitor:eDP-1, on-created-empty: alacritty;\
    workspace 2,monitor:eDP-1, on-created-empty: alacritty;\
    workspace 3,monitor:eDP-1;\
    workspace 4,monitor:eDP-1;\
    workspace 5,monitor:eDP-1;\
    workspace 6,monitor:eDP-1, on-created-empty: obsidian;\
    workspace 7,monitor:eDP-1, on-created-empty: spotify;\
    workspace 8,monitor:eDP-1, on-created-empty: \"${pkgs.neovide}/bin/neovide -- --cmd 'cd ~/vaults/Knowledge/'\";\
    workspace 9,monitor:eDP-1, on-created-empty: discord;\
    workspace 10,monitor:eDP-1"
      '';
      executable = true;
    };
  };
}
