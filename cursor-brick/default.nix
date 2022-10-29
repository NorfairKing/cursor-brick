{ mkDerivation, base, brick, cursor, lib, text }:
mkDerivation {
  pname = "cursor-brick";
  version = "0.1.0.1";
  src = ./.;
  libraryHaskellDepends = [ base brick cursor text ];
  homepage = "https://github.com/NorfairKing/cursor-brick#readme";
  license = lib.licenses.mit;
}
