{ config, lib, pkgs, ...}: 
{
programs.waybar = {
  enable = true;
    style = ''
* {
    border: none;
    border-radius: 0;
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 14px;
    transition-duration: 0.2s;    
    min-height: 0;
}

window#waybar {
background-color: transparent;
color: transparent;
}
window#waybar.empty #window {
  padding: 0px;
  margin: 0px;
  border: 0px;
  background: transparent;
}

#workspaces {
	background-color: #24283b;
	margin: 5px;
	margin-left: 2px;
	border-radius: 5px;
}
#workspaces button {
    padding: 5px 10px;
    color: #c0caf5;
}

#workspaces button.active {
    color: #24283b;
    background-color: #7aa2f7;
    border-radius: 5px;
}

#workspaces button:hover {
	background-color: #7dcfff;
	color: #24283b;
	border-radius: 5px;
}

#custom-date, #clock, #battery, #pulseaudio, #network, #temperature {
	background-color: #24283b;
	padding: 5px 10px;
	margin: 5px 0px;
}
#tray {
        background-color: #24283b;
        border-radius: 5px;
        padding: 5px 8px;
        margin: 5px 6px;
}
#custom-date {
	color: #7dcfff;
}
#window {
 background-color: #24283b;
 color: #db4b4b;
 padding: 5px 13px;
 margin: 5px 1px;
 border-radius: 5px;
}
#custom-power {
	color: #24283b;
	background-color: #db4b4b;
	border-radius: 5px;
	padding: 2px 11px;
        margin: 5px 5px;
}

#workspaces button.urgent {
    color: #040305;
    background-color: #db4b4b;
    border-radius: 5px;
}
#clock {
    color: #b48ead;
}
#temperature {
 color: #e0af68;
 border-radius: 0px 5px 5px 0px;
 margin: 5px 7px 5px 0px;
}
#battery {
    color: #9ece6a;
}

#battery.charging {
    color: #9ece6a;
}

#battery.warning:not(.charging) {
    background-color: #f7768e;
    color: #24283b;
    border-radius: 5px 5px 5px 5px;
}

#network {
	color: #f7768e;
	border-radius: 5px 0px 0px 5px;
}

#pulseaudio {
	color: #e0af68;
}
     ''; 
settings = [
{
    "position" = "top";
    "layer" = "top";
    "height" = 30;
    "modules-left" = ["custom/power" "hyprland/workspaces"];
    "modules-center" = ["hyprland/window"];
    "modules-right" = ["tray" "network" "pulseaudio" "battery" "custom/date" "clock" "temperature"];
      #Modules configuration
	"hyprland/workspaces" = {
		"all-outputs" = true;
                "format" = "{icon}";
                  "on-scroll-up" = "hyprctl dispatch workspace e+1";
                   "on-scroll-down" = "hyprctl dispatch workspace e-1";
	        "on-click" = "activate";
	        "persistent_workspaces" = {
                        "1" = [];
	                "2" = [];
	                "3" = [];
	                "4" = [];
	                "5" = [];
	                "6" = [];
	                "7" = [];
	                "8" = [];
	                "9" = [];
	                "10" = [];
	};
                "format-icons" = {
                        "1" = "󰋜";
                        "2" = "󰖟";
                        "3" = "󰠮";
                        "4" = "󰭹";
                        "5" = "󱓷";
                        "6" = "󱇧";
                        "7" = "󰊢";
                        "8" = "󰖲";
                        "9" = "󰕧";
                        "10" = "󰝚";
         };
     };
	"custom/date" = {
                "format" = "󰸗 {}";
		"interval" = 3600;
		"exec"= "$HOME/bin/waybar-date.sh";
 };
      "hyprland/window" = {
               "format" = "{}";
                "max-length" = 80;
};
      "tray" = {
		"icon-size" = 18;
		"spacing" = 10;
       };
	"custom/power" = {
		"format" = "󰐥"; 
		"on-click" = "/home/ash18/.config/rofi/powermenu/type-4/powermenu.sh";
                "on-click-release" = "sleep 1";
};
	"clock" = {
		"format" = "󰅐 {:%I:%M %p}";
                "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
                "format-alt" = "{:%Y-%m-%d}";
	};
	"network" = {
                "format-wifi" = "  {essid}";
                "format-ethernet" = "{ifname}: {ipaddr}/{cidr} ";
                "format-linked" = "{ifname} (No IP) ";
                "format-disconnected" =  "󰤮 Disconnected";
                "format-alt" =  "{ifname}: {ipaddr}/{cidr}";
	};

      "temperature" = {
       "critical-threshold" = 95;
       "interval" = 5;
        "hwmon-path" = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon0/temp1_input";
        "format" = "{icon}  {temperatureC}°C";
        "format-icons" = [
         ""
         ""
         ""
         ""
         ""
      ];
         "tooltip" = true;
};

	"pulseaudio" = {
		"format" = "{icon}  {volume}%";
                "format-muted" = "󰖁 Muted";
        "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" "" ""];
        };
    };
}
     ];
  };
}
