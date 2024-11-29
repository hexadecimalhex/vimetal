{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    parts.url = "github:hercules-ci/flake-parts";
    naersk.url = "github:nix-community/naersk";
    rust = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ nixpkgs, parts, rust, naersk, ... }:
    parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      perSystem = { system, ... }:
        let
          overlays = [ (import rust) ];
          pkgs = import nixpkgs { inherit system overlays; };
          toolchain = pkgs.pkgsBuildHost.rust-bin.fromRustupToolchainFile
            ./rust-toolchain.toml;
          naersk-lib = pkgs.callPackage naersk {
            cargo = toolchain;
            rustc = toolchain;
          };
        in {
          devShells.default = pkgs.mkShell {
            packages = let
              buildDeps = with pkgs; [ pkg-config luajit ];
              developmentDeps = with pkgs; [
                just
                bacon
                nil
                nixfmt-classic
                taplo
              ];
            in [ toolchain ] ++ buildDeps ++ developmentDeps;
          };
          packages =
            import ./nix/packages.nix (pkgs // { inherit naersk-lib; });
        };
    };
}
