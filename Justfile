_default:
  just --list

watch:
  bacon clippy

run:
  nix run .#neovim -- .
