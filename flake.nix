{
  # comment out to use whatever you have built your system with
  # inputs.nixpkgs.url = "nixpkgs-dev";

  outputs =
    inputs@{
      self,
      nixpkgs, # use system provided nixpkgs to prevent another copy in the store
    }:
    {
      lib = rec {
        darwinSystems = nixpkgs.lib.filter (nixpkgs.lib.hasSuffix "-darwin") nixpkgs.lib.systems.flakeExposed;
        forAllSystems = nixpkgs.lib.genAttrs darwinSystems;
        matchingLinuxSystem = nixpkgs.lib.replaceStrings [ "-darwin" ] [ "-linux" ];

        nixosVM =
          darwinSystem: additionalModules:
          let
            nixosArgs = {
              system = matchingLinuxSystem darwinSystem;
              modules = [
                {
                  _module.args = {
                    inherit inputs;
                    userName = "obe";
                    hostName = "lix";
                    userPass = "idefix";
                    withAutoShutdown = true;
                    withNaturalScrolling = true;
                  };
                }
                {
                  imports = [
                    modules/base.nix
                    modules/vm.nix
                    modules/sharedDirectories.nix
                    modules/standardPackages.nix
                  ] ++ additionalModules;
                }
              ];
            };
          in
          (nixpkgs.lib.nixosSystem nixosArgs).config.system.build.vm;
      };

      packages = self.lib.forAllSystems (system: rec {
        # support 'nix run' without arguments or just with path to directory with flake
        default = text;

        text = self.lib.nixosVM system [
          modules/autoShutdownOnLoggout.nix
        ];

        graphic = self.lib.nixosVM system [
          modules/nixColoredWM
        ];
      });
    };
}
