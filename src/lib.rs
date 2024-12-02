#![warn(clippy::nursery)]
#![warn(clippy::pedantic)]

mod config;
mod utils;
mod colourscheme;

use nvim_oxi::Result;

#[nvim_oxi::plugin]
fn vimetal() -> Result<()> {
    // TODO: implement some error handling here so panics are actually legible.
    config::setup_options()
        .expect("failed to setup config.");
    colourscheme::setup()
        .expect("failed to setup colourscheme.");

    Ok(())
}
