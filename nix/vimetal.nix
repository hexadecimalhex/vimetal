{ rustPlatform, pkg-config, luajit, stdenvNoCC, lib, ... }:
let
  inherit (lib) sources;
  version =
    (builtins.fromTOML (builtins.readFile ../Cargo.toml)).package.version;
in rec {
  # derivation containing the compiled `.so` lib.
  vimetal-lib = rustPlatform.buildRustPackage {
    inherit version;
    pname = "vimetal-lib";
    nativeBuildInputs = [ pkg-config ];
    buildInputs = [ luajit ];
    src = sources.cleanSource ../.;
    cargoHash = "sha256-TP+kRArVv6jPClwwbP7ItOZ3eKr44T4TJNNPrDE/RcM=";
  };
  # derivation containing the Lua files to be used by Neovim.
  vimetal = stdenvNoCC.mkDerivation {
    inherit version;
    pname = "vimetal";
    src = vimetal-lib;
    buildPhase = ''
      runHook preBuild

      mkdir -p "$out/lua"
      cp "$src/lib/libvimetal.so" "$out/lua/vimetal.so"
      echo -e "vim.cmd \"set rtp+=$out\"" >> "$out/init.lua"
      echo -e "require \"vimetal\"" >> "$out/init.lua"

      runHook postBuild
    '';
  };
}
