{ lib, pkgs, config, ... }:
{
  environment.etc = {
    "sway/config".text = ''
      # Variables
        set $mod Mod4

        set $left  h
        set $down  j
        set $up    k
        set $right l

        set $gray  #323232
        set $blue  #3daee9
        set $white #eff0f1
        set $black #900000
        set $red   #cb4b16
        set $bg    #31363b

      # I/O
        input "type:keyboard" {
          xkb_layout eu,us(symbolic)
        }

        input "type:touchpad" {
          tap enable
        }
      
        output * {
          scale 1
        }

      # Etc
        xwayland disable

      # Appearance
        client.focused          $blue $bg  $white $blue  $blue
        client.focused_inactive $bg   $bg  $white $bg    $bg
        client.unfocused        $bg   $bg  $white $bg    $bg
        client.urgent           $red  $red $white $black $black

        default_border pixel 1
        font "Noto Sans Emoji" 12

      # Layout
        floating_modifier $mod normal

        bindsym $mod+Left   focus left
        bindsym $mod+$left  focus left
        bindsym $mod+Down   focus down
        bindsym $mod+$down  focus down
        bindsym $mod+Up     focus up
        bindsym $mod+$up    focus up
        bindsym $mod+Right  focus right
        bindsym $mod+$right focus right

        bindsym $mod+Shift+Left   move left
        bindsym $mod+Shift+$left  move left
        bindsym $mod+Shift+Down   move down
        bindsym $mod+Shift+$down  move down
        bindsym $mod+Shift+Up     move up
        bindsym $mod+Shift+$up    move up
        bindsym $mod+Shift+Right  move right
        bindsym $mod+Shift+$right move ringt

        bindsym $mod+1 workspace number 1
        bindsym $mod+2 workspace number 2
        bindsym $mod+3 workspace number 3
        bindsym $mod+4 workspace number 4
        bindsym $mod+5 workspace number 5
        bindsym $mod+6 workspace number 6
        bindsym $mod+7 workspace number 7
        bindsym $mod+8 workspace number 8
        bindsym $mod+9 workspace number 9
        bindsym $mod+0 workspace number 10

        bindsym $mod+Shift+1 move container to workspace number 1
        bindsym $mod+Shift+2 move container to workspace number 2
        bindsym $mod+Shift+3 move container to workspace number 3
        bindsym $mod+Shift+4 move container to workspace number 4
        bindsym $mod+Shift+5 move container to workspace number 5
        bindsym $mod+Shift+6 move container to workspace number 6
        bindsym $mod+Shift+7 move container to workspace number 7
        bindsym $mod+Shift+8 move container to workspace number 8
        bindsym $mod+Shift+9 move container to workspace number 9
        bindsym $mod+Shift+0 move container to workspace number 10

        bindsym $mod+b           splith
        bindsym $mod+v           splitv
        bindsym $mod+s           layout stacking
        bindsym $mod+w           layout tabbed
        bindsym $mod+e           toggle split
        bindsym $mod+f           fullscreen
        bindsym $mod+space       focus mode_toggle
        bindsym $mod+Shift+space floating toggle

      # Key bindings
        set $mod Mod4
        bindsym $mod+Shift+q   kill
        bindsym $mod+c         reload
        bindsym $mod+Return    exec ${pkgs.foot}/bin/foot
        bindsym $mod+d         exec ${pkgs.wofi}/bin/wofi --gtk-dark --show drun
        bindsym $mod+Backspace exec ${pkgs.swaylock}/bin/swaylock -f -c 00000000
        bindsym XF86Explorer   input "type:keyboard" xkb_switch_layout next

        bindsym --locked XF86AudioMicMute      exec ${pkgs.wireplumber}/bin/wpctl set-mute   @DEFAULT_AUDIO_SOURCE@ toggle
        bindsym --locked XF86AudioMute         exec ${pkgs.wireplumber}/bin/wpctl set-mute   @DEFAULT_AUDIO_SINK@ toggle
        bindsym --locked XF86AudioLowerVolume  exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.2
        bindsym --locked XF86AudioRaiseVolume  exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.2
        bindsym --locked XF86MonBrightnessDown exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-
        bindsym --locked XF86MonBrightnessUp   exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+

	# Thinks to make sure are running
        exec_always {
          ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme 'Breeze'
          ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface icon-theme 'breeze-dark'
          ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
          ${pkgs.glib}/bin/gsettings set org.gnome.desktop.wm.preferences button-layout ' '
          ${pkgs.swayidle}/bin/swayidle -w before-sleep '${pkgs.swaylock}/bin/swaylock -f -c 00000000'
        }

      # Start environment
        exec ${pkgs.systemd}/bin/systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP
        exec ${pkgs.systemd}/bin/systemctl --user start nixos-fake-graphical-session.target
    '';
    "xdg/swaync/config.json".text = ''
      {
        "$schema": "/etc/xdg/swaync/configSchema.json",
        "positionX": "right",
        "positionY": "top",
        "layer": "overlay",
        "control-center-layer": "top",
        "layer-shell": true,
        "cssPriority": "application",
        "control-center-margin-top": 0,
        "control-center-margin-bottom": 0,
        "control-center-margin-right": 0,
        "control-center-margin-left": 0,
        "notification-2fa-action": true,
        "notification-inline-replies": false,
        "notification-icon-size": 64,
        "notification-body-image-height": 100,
        "notification-body-image-width": 200,
        "timeout": 10,
        "timeout-low": 5,
        "timeout-critical": 0,
        "fit-to-screen": true,
        "control-center-width": 500,
        "control-center-height": 600,
        "notification-window-width": 500,
        "keyboard-shortcuts": true,
        "image-visibility": "when-available",
        "transition-time": 200,
        "hide-on-clear": false,
        "hide-on-action": true,
        "script-fail-notify": true,
        "notification-visibility": {
          "example-name": {
            "state": "muted",
            "urgency": "Low",
            "app-name": "Spotify"
          }
        },
        "widgets": [
          "inhibitors",
          "title",
          "dnd",
          "notifications"
        ],
        "widget-config": {
          "inhibitors": {
            "text": "Inhibitors",
            "button-text": "Clear All",
            "clear-all-button": true
          },
          "title": {
            "text": "Notifications",
            "clear-all-button": true,
            "button-text": "Clear All"
          },
          "dnd": {
            "text": "Do Not Disturb"
          },
          "label": {
            "max-lines": 5,
            "text": "Label Text"
          },
          "mpris": {
            "image-size": 96,
            "image-radius": 12
          }
        }
      }
    '';
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
      extraOptions = [
        "--unsupported-gpu"
      ];
      extraSessionCommands = ''
        # export WLR_RENDERER=vulkan
      '';
      extraPackages = with pkgs; [
        # vulkan-validation-layers
        swaylock
        swayidle
        brightnessctl
        foot
        wofi
        swaynotificationcenter
	gnome3.nautilus
	gnome3.evince
	chromium
        libsForQt5.breeze-gtk
        libsForQt5.breeze-icons
      ];
    };
    xwayland.enable = false;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    gnome.at-spi2-core.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };
}
