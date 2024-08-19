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
          exec = pkgs.lib.strings.concatStrings [
            "${pkgs.hyprland}/bin/hyprctl --batch dispatch \""
            (
              pkgs.lib.strings.concatStrings
              (
                pkgs.lib.strings.intersperse ";" [
  "keyword workspace= 1,monitor:eDP-1,                                  on-created-empty: alacritty"
  "keyword workspace= 2,monitor:eDP-1,                                  on-created-empty: alacritty"
  "keyword workspace= 3,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL"
  "keyword workspace= 4,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL"
  "keyword workspace= 5,monitor:desc:Dell Inc. DELL U2410 F525M29HC43L, on-created-empty: firefox"
  "keyword workspace= 6,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL, on-created-empty: obsidian"
  "keyword workspace= 7,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL, on-created-empty: spotify"
  "keyword workspace= 8,monitor:eDP-1,                                  on-created-empty: \\\"${pkgs.neovide}/bin/neovide -- --cmd 'cd ~/vaults/Knowledge/'\\\""
  "keyword workspace= 9,monitor:desc:Dell Inc. DELL U2410 F525M27UD0DL, on-created-empty: discord"
  "keyword workspace=10,monitor:eDP-1"
                ]
              )
            )
            "\""
          ];
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
          exec = pkgs.lib.strings.concatStrings [
            "${pkgs.hyprland}/bin/hyprctl --batch dispatch \""
            (
              pkgs.lib.strings.concatStrings
              (
                pkgs.lib.strings.intersperse ";" [
  "keyword workspace= 1,monitor:eDP-1, on-created-empty: alacritty"
  "keyword workspace= 2,monitor:eDP-1, on-created-empty: alacritty"
  "keyword workspace= 3,monitor:eDP-1"
  "keyword workspace= 4,monitor:eDP-1"
  "keyword workspace= 5,monitor:eDP-1"
  "keyword workspace= 6,monitor:eDP-1, on-created-empty: obsidian"
  "keyword workspace= 7,monitor:eDP-1, on-created-empty: spotify"
  "keyword workspace= 8,monitor:eDP-1, on-created-empty: \\\"${pkgs.neovide}/bin/neovide -- --cmd 'cd ~/vaults/Knowledge/'\\\""
  "keyword workspace= 9,monitor:eDP-1, on-created-empty: discord"
  "keyword workspace=10,monitor:eDP-1"
                ]
              )
            )
            "\""
          ];
        };
      }
    ];
  };
}
