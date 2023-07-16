{ pkgs, config, lib, ... }:

let
  opacity = lib.strings.floatToString config.stylix.opacity.terminal;
  modifier = "SUPER";
in
{
  xdg.configFile."hypr/gaps.sh" = {
    executable = true;
    text = /* bash */ ''
      #/usr/bin/env bash
      hyprctl keyword general:gaps_out $((10 - $(hyprctl getoption general:gaps_out -j | jq -r ".int")))
      hyprctl keyword general:gaps_in $((5 - $(hyprctl getoption general:gaps_in -j | jq -r ".int")))
      hyprctl keyword general:border_size $((2 - $(hyprctl getoption general:border_size -j | jq -r ".int")))
      hyprctl keyword decoration:rounding $((8 - $(hyprctl getoption decoration:rounding -j | jq -r ".int")))
    '';
  };

  xdg.configFile."hypr/hyprland.conf".text = with config.lib.stylix.colors; /* bash */ ''
    env=XCURSOR_SIZE,24
    env=BROWSER,firefox
    env=GTK_IM_MODULE,fcitx
    env=QT_IM_MODULE,fcitx
    env=XMODIFIERS,@im=fcitx
    env=SDL_IM_MODULE,fcitx
    env=GLFW_IM_MODULE,ibus
    env=SWWW_TRANSITION,grow
    env=SWWW_TRANSITION_STEP,200
    env=SWWW_TRANSITION_DURATION,1.5
    env=SWWW_TRANSITION_FPS,240
    env=SWWW_TRANSITION_WAVE,80,40

    env = LIBVA_DRIVER_NAME,nvidia
    env = XDG_SESSION_TYPE,wayland
    env = GBM_BACKEND,nvidia-drm
    env = __GLX_VENDOR_LIBRARY_NAME,nvidia
    env = WLR_NO_HARDWARE_CURSORS,1

    monitor= , 2560x1440@165, auto, 1.25

    exec-once = swww init
    exec-once = wpctl set-volume @DEFAULT_AUDIO_SINK@ 20%
    exec-once = sleep 0.5 && ironbar
    exec-once = fcitx5
    exec-once = hyprctl dispatch workspace 5000000
    exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1

    input {
      kb_layout = us
      accel_profile = flat
      follow_mouse = 1
      mouse_refocus = 0
      sensitivity = 0
      touchpad {
        natural_scroll = yes
        disable_while_typing = no
      }
      repeat_rate = 50
      repeat_delay = 300
    }

    general {
      gaps_in = 0
      gaps_out = -1
      border_size = 0
      col.active_border = rgba(${base03}ee) rgba(${base04}ee) 45deg
      col.inactive_border = rgba(${base02}99)
      layout = master
    }

    decoration {
      rounding = 0
      blur = yes
      blur_size = 4
      blur_passes = 2
      blur_new_optimizations = yes
      drop_shadow = yes
      shadow_range = 4
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)
      fullscreen_opacity = 0.9999999
      dim_strength = 0.25
    }

    animations {
      enabled = yes
      bezier = myBezier, 0.05, 0.9, 0.1, 1.05
      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default, slidevert
      animation = specialWorkspace, 1, 6, default, fade
    }

    dwindle {
      preserve_split = yes
      special_scale_factor = 1
    }

    master {
      new_is_master = no
      new_on_top = no
      mfact = 0.65
      special_scale_factor = 1
    }

    gestures {
      workspace_swipe = yes
    }

    device:synps/2-synaptics-touchpad {
      sensitivity = 0.75
      accel_profile = flat
      natural_scroll = yes
      disable_while_typing = no
    }

    device:tpps/2-elan-trackpoint {
      sensitivity = 0.5
      accel_profile = flat
    }

    binds {
      allow_workspace_cycles = yes
    }

    $mainMod = ${modifier}

    # 系统
    bind = $mainMod, L, exec, swaylock # 锁屏

    # 窗口控制
    bind = $mainMod, X, killactive # 关闭窗口
    bind = $mainMod, F, togglefloating, # 浮动窗口
    bind = $mainMod, return, fullscreen, # 全屏
    bindm = $mainMod, mouse:272, movewindow # 左键移动
    bindm = $mainMod, mouse:273, resizewindow # 右键调整大小
    bind = $mainMod SHIFT, P, pseudo, # dwindle
    bind = $mainMod SHIFT, T, togglesplit, # dwindle

    # 软件
    bind = $mainMod, Q, exec, kitty # 终端
    bind = $mainMod, C, exec, neovim # VSCode
    bind = $mainMod, G, exec, firefox # Chrome

    # 移动当前屏幕聚焦
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d
    bind = ALT, Tab, movefocus, d

    # 调整窗口大小
    ## 20px
    bind = $mainMod SHIFT, right, resizeactive, 20 0
    bind = $mainMod SHIFT, left, resizeactive, -20 0
    bind = $mainMod SHIFT, up, resizeactive, 0 -20
    bind = $mainMod SHIFT, down, resizeactive, 0 20
    ## 40px
    bind = $mainMod CTRL, left, resizeactive, -40 0
    bind = $mainMod CTRL, right, resizeactive, 40 0
    bind = $mainMod CTRL, up, resizeactive, 0 -40
    bind = $mainMod CTRL, down, resizeactive, 0 40

    # 移动窗口到工作区
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # 切换工作区
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    layerrule = blur,ironbar
    layerrule = blur,notifications

    windowrulev2 = nomaxsize,class:^(osu\.exe)$
    windowrulev2 = opaque,class:^(kitty)$
    windowrulev2 = noblur,class:^(kitty)$
    windowrulev2 = tile,class:^(.qemu-system-x86_64-wrapped)$
    windowrulev2 = opacity ${opacity} ${opacity},class:^(thunar)$

    misc {
      disable_hyprland_logo = yes
      animate_manual_resizes = yes
      animate_mouse_windowdragging = yes
      disable_autoreload = yes
    }
  '';
}
