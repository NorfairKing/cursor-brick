final:
previous:
with final.haskell.lib;
{
  cursorBrickPackages =
    let pkg = name:
      (buildStrictly (final.haskellPackages.callCabal2nixWithOptions name (../. + "/${name}") "--no-hpack" { }));
    in
    final.lib.genAttrs [
      "cursor-brick"
    ]
      pkg;
  haskellPackages = previous.haskellPackages.override (old: {
    overrides = final.lib.composeExtensions (old.overrides or (_: _: { })) (
      self: super: final.cursorBrickPackages
    );
  });
}
