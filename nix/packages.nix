{ wrapNeovimUnstable, neovim-unwrapped, neovimUtils, ... }@pkgs:
let
  vimetal = import ./vimetal.nix pkgs;
  config = neovimUtils.makeNeovimConfig {
    plugins = with pkgs.vimPlugins; [ oxocarbon-nvim ];
  };
in {
  neovim = (wrapNeovimUnstable neovim-unwrapped config).overrideAttrs {
    generatedWrapperArgs =
      [ "--add-flags" "-u ${vimetal.vimetal-plugin}/init.lua" ];
  };
} // vimetal
