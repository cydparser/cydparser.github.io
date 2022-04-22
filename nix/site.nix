{ mkDerivation, base, hakyll, lib }:
mkDerivation {
  pname = "site";
  version = "0.0.0.0";
  src = ../.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base hakyll ];
  license = "unknown";
  hydraPlatforms = lib.platforms.none;
}
