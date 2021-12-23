{
  description = "idris-template's description";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };
  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ] (system:
      let
        overlays = [ ];
        pkgs =
          import nixpkgs { inherit system overlays; config.allowBroken = true; };
        idrisPkgs =
          if system == "aarch64-darwin"
          then import nixpkgs { system = "x86_64-darwin"; }  # Rosetta only, no M1 build available
          else pkgs;
        project = returnShellEnv:
          pkgs.mkShell {
            packages = with pkgs; [
              idrisPkgs.idris2
              nixpkgs-fmt
              nodePackages.live-server
              goreman
              entr
              nodejs
              nodePackages.concurrently
            ];
          };
      in
      {
        # Used by `nix build` & `nix run` (prod exe)
        defaultPackage = project false;

        # Used by `nix develop` (dev shell)
        devShell = (project true).overrideAttrs (oa: {
          shellHook = oa.shellHook + ''
            export DYLD_LIBRARY_PATH=${idrisPkgs.idris2}/lib:$DYLD_LIBRARY_PATH
          '';
        });
      });
}
