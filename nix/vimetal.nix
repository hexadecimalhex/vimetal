{ pkg-config, luajit, stdenvNoCC, naersk-lib, ... }:
let
  version =
    (builtins.fromTOML (builtins.readFile ../Cargo.toml)).package.version;
in rec {
  # derivation containing the compiled library.
  vimetal-lib = naersk-lib.buildPackage {
    inherit version;
    pname = "vimetal-lib";
    src = ../.;
    nativeBuildInputs = [ pkg-config ];
    buildInputs = [ luajit ];
    copyLibs = true; # no binaries here, only libs.
  };
  # derivation containing the plugin.
  vimetal-plugin = stdenvNoCC.mkDerivation {
    inherit version;
    pname = "vimetal";
    src = vimetal-lib;
    buildPhase = ''
      runHook preBuild

      mkdir -p "$out/lua"
      # nvim looks for .so files under /lua folders in its runtime path
      cp "$src/lib/libvimetal.so" "$out/lua/vimetal.so"
      # add vimetal to the runtime path
      echo -e "vim.cmd \"set rtp+=$out\"" >> "$out/init.lua"
      # load vimetal.
      echo -e "require \"vimetal\"" >> "$out/init.lua"

      runHook postBuild
    '';
  };
}
