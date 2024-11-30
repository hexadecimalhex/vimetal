#![warn(clippy::nursery)]
#![warn(clippy::pedantic)]

mod config;
mod utils;

use nvim_oxi::Result;

#[nvim_oxi::plugin]
fn vimetal() -> Result<()> {
    config::setup_options()?;

    Ok(())
}
