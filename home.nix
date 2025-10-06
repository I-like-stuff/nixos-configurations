{ config, pkgs, lib, hyprland, inputs, ... }: {

 # Let Home Manager install and manage itself.
programs.home-manager.enable = true; 
home = {
 username = "ash18";
 homeDirectory = "/home/ash18";
 stateVersion = "23.05";
 packages = with pkgs; [ 
]; };  
   imports = [ inputs.spicetify-nix.homeManagerModules.default 
  ./waybar.nix ./neovim.nix ./hypr.nix
];
# Setting up default applications for use
xdg.mimeApps = {
 enable = true;
defaultApplications = let
   textEditor = "nvim.desktop";
   fileBrowser = "ranger.desktop";
   webBrowser = "librewolf.desktop";
in {
# Web Browser
 "text/html" = webBrowser;
 "x-scheme-handler/http" = webBrowser;
 "x-scheme-handler/https" = webBrowser;
 "x-scheme-handler/chrome" = webBrowser;
 "x-scheme-handler/about" = webBrowser;
 "x-scheme-handler/unknown" = webBrowser;
# Text Editor
 "application/x-shellscript" = textEditor;
 "text/plain" = textEditor;
 "text/x-python3" = textEditor;
 "text/javascript" = textEditor;
# File Browser 
"x-scheme-handler/file" = fileBrowser;
 }; 
};
#enabling GTK themes
   gtk = {
    enable = true;
     theme = {
       name = "Orchis-Dark";
       package = pkgs.orchis-theme.override {
       tweaks = [ "black" ];
     };
 };
  gtk4.extraConfig = {
     gtk-font-name = "Cantarell 10";
     gtk-xft-antialias = 1;
     gtk-xft-hinting = 1;
     gtk-xft-hintstyle= "hintmedium";
}; 
 
 iconTheme = {
            name  =  "Papirus";
            package = pkgs.papirus-icon-theme.override { color = "green"; };             
};  };
   
   dconf.settings= {
    "org/virt-manager/virt-manager/connections" = {
    autoconnect = ["qemu:///system"];
    uris = ["qemu:///system"];
}; };
  xdg.configFile."/home/ash18/.bashrc".text = ''
   eval "$(starship init bash)" '';
  xdg.desktopEntries.vesktop = {
categories = [ "Network" "InstantMessaging" "Chat" ];
exec = "vesktop --enable-blink-features=MiddleClickAutoscroll -enable-features=UseOzonePlatform --ozone-platform=wayland %U";
genericName = "Internet Messenger";
name = "Vesktop";
icon = "vesktop";
type = "Application";
 };
programs.spicetify = let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
enable = true;
theme = spicePkgs.themes.sleek;
colorScheme = "Futura";
enabledExtensions = with spicePkgs.extensions; [
 adblock ];
enabledCustomApps = with spicePkgs.apps; [ 
lyricsPlus ];
 };   

 programs.starship.enable = true;   
 xdg.configFile."/home/ash18/.config/kitty/kitty.conf".text = ''
  font_family   IosevkaTerm Nerd Font
  adjust_line_height 100%
  font_size 12.0 
  background_opacity 0.7
  macos_thicken_font  0.3
  confirm_os_window_close 0  
     foreground              #CDD6F4
     background              #1E1E2E
     selection_foreground    #1E1E2E
       cursor                  #F5E0DC
      cursor_text_color       #1E1E2E
      url_color               #F5E0DC
      selection_background    #F5E0DC
      active_border_color     #B4BEFE
      inactive_border_color   #6C7086
      wayland_titlebar_color system
macos_titlebar_color system
      active_tab_foreground   #11111B
     active_tab_background   #CBA6F7
inactive_tab_foreground #CDD6F4
inactive_tab_background #181825
tab_bar_background      #11111B
  bell_border_color       #F9E2AF
  # Colors for marks (marked text in the terminal)
mark1_foreground #1E1E2E
mark1_background #B4BEFE
mark2_foreground #1E1E2E
mark2_background #CBA6F7
mark3_foreground #1E1E2E
mark3_background #74C7EC

# The 16 terminal colors

# black
color0 #45475A
color8 #585B70

# red
color1 #F38BA8
color9 #F38BA8

# green
color2  #A6E3A1
color10 #A6E3A1

# yellow
color3  #F9E2AF
color11 #F9E2AF
# blue
color4  #89B4FA
color12 #89B4FA

# magenta
color5  #F5C2E7
color13 #F5C2E7

# cyan
color6  #94E2D5
color14 #94E2D5

# white
color7  #BAC2DE
color15 #A6ADC8 
'';
}
