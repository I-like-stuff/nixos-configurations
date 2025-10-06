# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, libs, ... }: 
{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./vfio.nix
];
 environment.sessionVariables = rec {
   GTK_THEME = "Orchis-Dark";
   TERMINAL = "kitty";
   BROWSER = "librewolf";
   EDITOR = "nvim";
};
 
 # Cachix
 nix.settings = {
   substituters = [ "https://ezkea.cachix.org" ];
   trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
};
 
 # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  networking.hostName = "nixos"; 

  # Enable networking
  networking.networkmanager.enable = true;
  # Set your time zone.
  time.timeZone = "Asia/Baghdad";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Configure keymap in X11
  services.xserver = {
  xkb = {
   layout = "us"; }; };
 # Enable CUPS to print documents.
  services.printing.enable = false;
  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };
 services.pulseaudio.enable = false;

  users = { 
     users.ash18 = {
     isNormalUser = true;
     description = "ash18";
     extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" ];
     packages = with pkgs; [
    ];
  };
};
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # NixOS Flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  kitty
  btop
  yt-dlp
  grim
  aria2
  input-remapper
  smartmontools
  lutris
  gopeed
  inputs.mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
  mangohud
  gamemode
  ungoogled-chromium
  obs-studio
  inputs.swww.packages.${pkgs.system}.swww
  dwarfs
  librewolf
  fuse-overlayfs
  gamescope
  vesktop
  pinta
  wineWowPackages.waylandFull
  hyprpicker
  glibc
  inputs.fjordlauncher.packages.${pkgs.system}.fjordlauncher
  jmtpfs
  unar
  rofi
  cliphist
  nautilus
  protonvpn-gui
  wl-clipboard
  wl-clip-persist
  slurp
  pavucontrol
  imv
  mpv
  neofetch
  git
  jdk17
  qbittorrent 
  ranger
  procps
  ];
  #List services that you want to enable:
  services.xserver.exportConfiguration = true;
  programs.dconf.enable = true;
  programs.hyprland.enable = true;
  services.input-remapper.enable = true;
# Enabling steam 
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};
  services.smartd = {
   enable = true;
   devices = [
    {
     device = "/dev/disk/by-id/ata-Samsung_SSD_870_EVO_500GB_S5Y1NF0R442222F";
    }
  ];
};
  
  services.displayManager.gdm.enable = true;
  services.dbus.enable = true;
  xdg.portal = {
   enable = true;
   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
};
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

fonts = {
enableDefaultPackages = true;
packages = with pkgs; [
 noto-fonts
 noto-fonts-cjk-sans
 nerd-fonts.iosevka-term
 nerd-fonts.jetbrains-mono
 nerd-fonts.agave
 cantarell-fonts
];
}; 
   }
