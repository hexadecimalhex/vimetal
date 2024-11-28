{ wrapNeovimUnstable, neovim-unwrapped, neovimUtils, ... }@pkgs:
let
  inherit (import ./vimetal.nix pkgs) vimetal;
  config = neovimUtils.makeNeovimConfig { };
in {
  inherit vimetal;
  neovim = (wrapNeovimUnstable neovim-unwrapped config).overrideAttrs {
    generatedWrapperArgs = [ "--add-flags" "-u ${vimetal}/init.lua" ];
  };
}
