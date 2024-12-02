# vimetal
an experimental Neovim configuration, using its [C API](https://neovim.io/doc/user/api.html) 
and [Lua bindings](https://docs.rs/mlua/latest/mlua)
with Rust instead of Lua.

for now, this uses [Nix](https://nixos.org/) for building and plugin management, so that's essential.

### building
this project uses [naersk](https://github.com/nix-community/naersk) to build Rust code (mainly for caching),
and the compiled code is then loaded as a library into Neovim.

`nix {build|run} .#neovim` to build or run the project.
