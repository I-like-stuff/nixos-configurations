{
 description = "NixOS configuration";

inputs = {
   nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
   home-manager = {
   url = "github:nix-community/home-manager";
   inputs.nixpkgs.follows = "nixpkgs";
};
   swww.url = "github:LGFae/swww";
   spicetify-nix = { 
    url = "github:Gerg-L/spicetify-nix";
    inputs.nixpkgs.follows = "nixpkgs";
};
   aagl = {
    url= "github:ezKEa/aagl-gtk-on-nix";
    inputs.nixpkgs.follows = "nixpkgs";
};  
   mcmojave-hyprcursor.url = "github:libadoxon/mcmojave-hyprcursor";
   fjordlauncher.url = "github:hero-persson/FjordLauncherUnlocked";
}; 
outputs = inputs@{ self, nixpkgs, home-manager, aagl, ... }: 

 {
     nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem rec {
        specialArgs = { inherit self system inputs; };
        system = "x86_64-linux";
        modules = [
	{
          imports = [ aagl.nixosModules.default ];
          nix.settings = aagl.nixConfig;
          programs.anime-game-launcher.enable = true;
 } 
	  ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.ash18 =  import ./home.nix; 
            extraSpecialArgs = { inherit inputs; };
           };
          }
        ];
      };
    };
  };
}  
