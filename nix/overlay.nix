final:
  previous:
    with final.haskell.lib;
    {
      cursorBrickPackages = 
            let pkg = name:
                (failOnAllWarnings (final.haskellPackages.callCabal2nix name (../. + "/${name}") {}));
            in final.lib.genAttrs [
              "cursor-brick"
            ] pkg;
      haskellPackages = previous.haskellPackages.override (old: {
        overrides = final.lib.composeExtensions (old.overrides or (_: _: {})) (
          self: super: final.cursorBrickPackages
        );
      });
    }
