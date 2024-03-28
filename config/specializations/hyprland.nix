{ pkgs, inputs, lib, config, username, gtkThemeFromScheme, ... }:

let
  hyprplugins = inputs.hyprland-plugins.packages.${pkgs.system};
  inherit (import ../../options.nix)
    systemCpuType
    systemGpuType
    mainKbdLayout
    sdlVideoDriver
    secondaryKbdLayout
    theme
    userKeyboundTerminal
    userMainBrowser;
in with lib; {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # stops cursor from becoming invisible, maybe not needed?
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = true; # mount, trash, and other fun functionalities
  services.tumbler.enable = true; # img thumbnail support

  services.gnome.gnome-keyring.enable = true;
  services.blueman.enable = true;


  # home manager funzies
  home-manager.users.${username} = let
    colorScheme = inputs.nix-colors.colorSchemes."${theme}";
    themePalette = colorScheme.palette;
  in {
    imports = [ inputs.nix-colors.homeManagerModules.default ];
    home.packages = with pkgs; [
      gnome.file-roller
      grim
      kitty
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      pavucontrol
      rofi-wayland
      slurp
      swayidle
      swaylock
      swaynotificationcenter
      swww
    ];
  
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
      plugins = [
        #hyprplugins.hyprtrails
      ];
      extraConfig = let
        modifier = "SUPER";
      in concatStrings [ ''
        monitor= eDP-1, preferred, auto, 1.333333
        monitor= , preferred, auto, 1
        windowrule = fullscreen, ^(wlogout)$
        windowrule = animation fade,^(wlogout)$
        workspace = 1,
        workspace = 2,
        workspace = 3,
        workspace = 4,
        workspace = 5,
        workspace = 6,
        workspace = 7,
        workspace = 8,
        workspace = 9,
        workspace = 10,
        general {
          gaps_in = 6
          gaps_out = 8
          border_size = 2
          col.active_border = rgba(${themePalette.base0C}ff) rgba(${themePalette.base0D}ff) rgba(${themePalette.base0B}ff) rgba(${themePalette.base0E}ff) 45deg
          col.inactive_border = rgba(${themePalette.base00}cc) rgba(${themePalette.base01}cc) 45deg
          layout = dwindle
          resize_on_border = true
        }

        input {
          kb_layout = ${mainKbdLayout}, ${secondaryKbdLayout}
	  kb_options = grp:alt_shift_toggle
          kb_options=caps:super
          follow_mouse = 1
          touchpad {
            natural_scroll = true
	   clickfinger_behavior = true
	   tap-to-click = true
	  }
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
          accel_profile = flat
        }
        env = LIBVA_DRIVER_NAME, nvidia
        env = GBM_BACKEND, nvidia-drm
        env = WLR_DRM_DEVICES, /dev/dri/card1:/dev/dri/card0
        env = WLR_NO_HARDWARE_CURSORS, 1
        env = NIXOS_OZONE_WL, 1
        env = NIXPKGS_ALLOW_UNFREE, 1
        env = XDG_CURRENT_DESKTOP, Hyprland
        env = XDG_SESSION_TYPE, wayland
        env = XDG_SESSION_DESKTOP, Hyprland
        env = GDK_BACKEND, wayland
        env = CLUTTER_BACKEND, wayland
        env = SDL_VIDEODRIVER, ${sdlVideoDriver}
        env = QT_QPA_PLATFORM, wayland
        env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
        env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
        env = MOZ_ENABLE_WAYLAND, 1
        ${if systemCpuType == "vm" then ''
          env = WLR_NO_HARDWARE_CURSORS,1
          env = WLR_RENDERER_ALLOW_SOFTWARE,1
        '' else ''
        ''}
        gestures {
          workspace_swipe = true
          workspace_swipe_fingers = 3
        }
        misc {
          mouse_move_enables_dpms = true
          key_press_enables_dpms = false
        }
        animations {
          enabled = yes
          bezier = wind, 0.05, 0.9, 0.1, 1.05
          bezier = winIn, 0.1, 1.1, 0.1, 1.1
          bezier = winOut, 0.3, -0.3, 0, 1
          bezier = liner, 1, 1, 1, 1
          animation = windows, 1, 6, wind, slide
          animation = windowsIn, 1, 6, winIn, slide
          animation = windowsOut, 1, 5, winOut, slide
          animation = windowsMove, 1, 5, wind, slide
          animation = border, 1, 1, liner
          animation = borderangle, 1, 30, liner, loop
          animation = fade, 1, 10, default
          animation = workspaces, 1, 5, wind
        }
        decoration {
          rounding = 10
          drop_shadow = false
          blur {
            enabled = true
            size = 5
            passes = 3
            new_optimizations = on
            ignore_opacity = on
          }
        }
        plugin {
          hyprtrails {
            color = rgba(${themePalette.base0A}ff)
          }
        }
        exec-once = $POLKIT_BIN
        exec-once = dbus-update-activation-environment --systemd --all
        exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        exec-once = swww init
        exec-once = waybar
        exec-once = swaync
        exec-once = wallsetter
        exec-once = nm-applet --indicator
        exec-once = blueman-applet
        exec-once = swayidle -w timeout 720 'swaylock -f' timeout 800 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f -c 000000'
        dwindle {
          pseudotile = true
          preserve_split = true
        }
        master {
          new_is_master = true
        }
        bind = ${modifier},Return,exec,${userKeyboundTerminal}
        bind = ${modifier},ALT,exec,rofi-launcher
        bind = ALT,SPACE,exec,rofi-launcher
        bind = ${modifier}SHIFT,Return,exec,rofi-launcher
        bind = ${modifier}SHIFT,W,exec,web-search
        bind = ${modifier}SHIFT,N,exec,swaync-client -op
        ${if userMainBrowser == "google-chrome" then ''
	  bind = ${modifier},W,exec,google-chrome-stable
        '' else ''
	  bind = ${modifier},W,exec,${userMainBrowser}
        ''}
        bind = ${modifier},E,exec,emopicker9000
        bind = ${modifier},S,exec,screenshootin
        bind = ${modifier},D,exec,discord --disable-gpu
        bind = ${modifier},O,exec,obs
        bind = ${modifier},G,exec,gimp
        bind = ${modifier}SHIFT,G,exec,godot4
        bind = ${modifier},T,exec,thunar
        bind = ${modifier},Y,exec,youtube-music --disable-gpu
        bind = ${modifier},M,exec,spotify --disable-gpu
        bind = ${modifier},Q,killactive,
        bind = ${modifier},P,pseudo,
        bind = ${modifier}SHIFT,I,togglesplit,
        bind = ${modifier},F,fullscreen,
        bind = ${modifier}SHIFT,F,togglefloating,
        bind = ${modifier}SHIFT,C,exit,
        bind = ${modifier}SHIFT,left,movewindow,l
        bind = ${modifier}SHIFT,right,movewindow,r
        bind = ${modifier}SHIFT,up,movewindow,u
        bind = ${modifier}SHIFT,down,movewindow,d
        bind = ${modifier}SHIFT,h,movewindow,l
        bind = ${modifier}SHIFT,l,movewindow,r
        bind = ${modifier}SHIFT,k,movewindow,u
        bind = ${modifier}SHIFT,j,movewindow,d
        bind = ${modifier},left,movefocus,l
        bind = ${modifier},right,movefocus,r
        bind = ${modifier},up,movefocus,u
        bind = ${modifier},down,movefocus,d
        bind = ${modifier},h,movefocus,l
        bind = ${modifier},l,movefocus,r
        bind = ${modifier},k,movefocus,u
        bind = ${modifier},j,movefocus,d
        bind = ${modifier},1,workspace,1
        bind = ${modifier},2,workspace,2
        bind = ${modifier},3,workspace,3
        bind = ${modifier},4,workspace,4
        bind = ${modifier},5,workspace,5
        bind = ${modifier},6,workspace,6
        bind = ${modifier},7,workspace,7
        bind = ${modifier},8,workspace,8
        bind = ${modifier},9,workspace,9
        bind = ${modifier},0,workspace,10
        bind = ${modifier}SHIFT,SPACE,movetoworkspace,special
        bind = ${modifier},SPACE,togglespecialworkspace
        bind = ${modifier}SHIFT,1,movetoworkspace,1
        bind = ${modifier}SHIFT,2,movetoworkspace,2
        bind = ${modifier}SHIFT,3,movetoworkspace,3
        bind = ${modifier}SHIFT,4,movetoworkspace,4
        bind = ${modifier}SHIFT,5,movetoworkspace,5
        bind = ${modifier}SHIFT,6,movetoworkspace,6
        bind = ${modifier}SHIFT,7,movetoworkspace,7
        bind = ${modifier}SHIFT,8,movetoworkspace,8
        bind = ${modifier}SHIFT,9,movetoworkspace,9
        bind = ${modifier}SHIFT,0,movetoworkspace,10
        bind = ${modifier}CONTROL,right,workspace,e+1
        bind = ${modifier}CONTROL,left,workspace,e-1
        bind = ${modifier},mouse_down,workspace, e+1
        bind = ${modifier},mouse_up,workspace, e-1
        bindm = ${modifier},mouse:272,movewindow
        bindm = ${modifier},mouse:273,resizewindow
        bind = ALT,Tab,cyclenext
        bind = ALT,Tab,bringactivetotop
        bind = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        bind = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        binde = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bind = ,XF86AudioPlay, exec, playerctl play-pause
        bind = ,XF86AudioPause, exec, playerctl play-pause
        bind = ,XF86AudioNext, exec, playerctl next
        bind = ,XF86AudioPrev, exec, playerctl previous
        bind = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
        bind = ,XF86MonBrightnessUp,exec,brightnessctl set +5%
      '' ];
    };
  };
}

