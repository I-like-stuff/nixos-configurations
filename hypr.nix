{ config, pkgs, lib, ...}: {

wayland.windowManager.hyprland = {
   enable = true;
   settings.exec-once = [
#"${pkgs.hyprpanel}/bin/hyprpanel"
]; 
   extraConfig = ''
 monitor=,preferred,auto,auto
# Execute your favorite apps at launch
exec-once = wl-paste -pw wl-copy -pc
exec-once=walker --gapplication-service
exec-once = wl-copy
exec-once= wl-paste --type text --watch cliphist store
exec-once = waybar
exec-once = swww-daemon --format xrgb
exec-once = wl-paste --type image --watch cliphist store
# Source a file (multi-file configs)
# source = ~/.config/hypr/myColors.conf

# Some default env vars.
env = HYPRCURSOR_SIZE,32
env = HYPRCURSOR_THEME,McMojave
# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
input {
    kb_layout = us,ara
    kb_model =
    kb_options = grp:lctrl_lalt_toggle
    kb_rules =
    mouse_refocus = false
    follow_mouse = 1

    touchpad {
        natural_scroll = no
    }

    sensitivity = 0.6 # -1.0 - 1.0, 0 means no modification.
}

general {

    gaps_in = 5
    gaps_out = 16
    border_size = 1
    resize_on_border = true
    col.active_border = rgba(33adffaa) 
    col.inactive_border = rgba(595959aa)
    layout = dwindle
}
decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    rounding = 3
    shadow:enabled = no
    blur {
      enabled = true
      size = 9
      passes = 3
  }
}

animations {
    enabled = yes

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

}

misc {
    disable_hyprland_logo = true
}

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default

dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    new_status = master
}

gestures {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe = off
}

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
device { 
  name = 2440890 
  sensitivity=-0.2
}

# Example windowrule v1
# windowrule = float, ^(kitty)$
# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
 
#Window Rules
layerrule = blur,rofi  
layerrule = noanim, ^(selection)$
layerrule = blur,gtk-layer-shell
$mainMod = SUPER
# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $SUPER, Return, exec, kitty
bind = $mainMod, Y, exec, waybar
bind = $mainMod, E, exec, pkill waybar && waybar
bind = $mainMod, Q, killactive, 
bind = $mainMod, M, exit,
bind = $mainMod, R, exec, /home/ash18/.config/rofi/applets/bin/wallpaper.sh
bind = $mainMod, l, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
bind = $mainMod, F, exec, /home/ash18/.config/rofi/launchers/type-2/launcher.sh
bind = $mainMod, C, fullscreen  
bind = $mainMod, V, togglefloating, 
bind = $mainMod, D, exec, grim -g "$(slurp)" - | wl-copy	
bind = $mainMod, X, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces with mainMod + [0-9]
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

# Move active window to a workspace with mainMod + SHIFT + [0-9]
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

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow
''; }; }
