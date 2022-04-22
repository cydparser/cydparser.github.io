{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachSystem [ utils.lib.system.x86_64-linux ] (system:
      let
        pkgs = import nixpkgs { inherit system; };

        ghcVersion = "8107";

        haskell-language-server = pkgs.haskell-language-server.override {
          supportedGhcVersions = [ ghcVersion ];
        };

        hs = pkgs.haskell.packages."ghc${ghcVersion}";

        site = hs.callPackage nix/site.nix { };
      in
      rec {
        apps.site = {
          type = "app";
          program = "{site}bin/site";
        };

        defaultApp = apps.site;

        # checks.site = TODO;

        devShell = pkgs.mkShell {
          inputsFrom = [
            site.env
          ];
          packages = [
            hs.cabal-fmt
            pkgs.cabal-install
            haskell-language-server
          ];
        };
      });
}
