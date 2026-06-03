{
  description = "cursor-brick";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-26.05";
    nixpkgs-25_11.url = "github:NixOS/nixpkgs?ref=nixos-25.11";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-25_11
    , pre-commit-hooks
    }:
    let
      system = "x86_64-linux";
      pkgsFor = nixpkgs: import nixpkgs {
        inherit system;
        overlays = [
          self.overlays.${system}
        ];
      };
      pkgs = pkgsFor nixpkgs;
    in
    {
      overlays.${system} = import ./nix/overlay.nix;
      packages.${system}.default = pkgs.haskellPackages.cursor-brick;
      checks.${system} =
        let
          backwardCompatibilityCheckFor = nixpkgs:
            let pkgs' = pkgsFor nixpkgs;
            in pkgs'.haskellPackages.cursor-brick;
          allNixpkgs = {
            inherit
              nixpkgs-25_11;
          };
          backwardCompatibilityChecks = pkgs.lib.mapAttrs (_: nixpkgs: backwardCompatibilityCheckFor nixpkgs) allNixpkgs;
        in
        backwardCompatibilityChecks // {
          pre-commit = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              hlint.enable = true;
              hpack.enable = true;
              ormolu.enable = true;
              nixpkgs-fmt.enable = true;
              nixpkgs-fmt.excludes = [ "default.nix" ];
              cabal2nix.enable = true;
            };
          };
        };
      devShells.${system}.default = pkgs.haskellPackages.shellFor {
        name = "cursor-brick-shell";
        packages = (p: with p; [
          cursor-brick
        ]);
        withHoogle = true;
        doBenchmark = true;
        buildInputs = with pkgs; [
          zlib
          cabal-install
        ] ++ self.checks.${system}.pre-commit.enabledPackages;
        shellHook = self.checks.${system}.pre-commit.shellHook;
      };
    };
}
