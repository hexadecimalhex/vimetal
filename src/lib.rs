#![warn(clippy::nursery)]
#![warn(clippy::pedantic)]

use nvim_oxi::{
    api::{self, opts::OptionOpts},
    Result,
};

#[nvim_oxi::plugin]
fn vimetal() -> Result<()> {
    api::set_option_value("nu", true, &OptionOpts::default())?;

    Ok(())
}
