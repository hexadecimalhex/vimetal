{ wrapNeovimUnstable, neovim-unwrapped, neovimUtils, ... }:
let config = neovimUtils.makeNeovimConfig { };
in {
  neovim = (wrapNeovimUnstable neovim-unwrapped config).overrideAttrs {
    # .lua loading compiled lib goes here i guess?
    generatedWrapperArgs = [ ];
  };
}
