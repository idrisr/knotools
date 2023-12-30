{ mkDerivation, attoparsec, base, bytestring, filepath, io-streams
, lib, microlens-platform, optparse-applicative, raw-strings-qq
, tasty, tasty-hunit, temporary, transformers
}:
mkDerivation {
  pname = "knotools";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    attoparsec base bytestring filepath io-streams microlens-platform
    optparse-applicative transformers
  ];
  executableHaskellDepends = [
    base bytestring io-streams microlens-platform temporary
    transformers
  ];
  testHaskellDepends = [
    attoparsec base bytestring microlens-platform raw-strings-qq tasty
    tasty-hunit
  ];
  license = "unknown";
  mainProgram = "newcover";
}
