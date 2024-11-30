use std::env;

use crate::utils::set_global;
use nvim_oxi::api::{self, opts::NotifyOpts, types::LogLevel};

/// Sets up `vim.o` and `vim.g` variables.
pub fn setup_options() -> Result<(), api::Error> {
    if let Ok(home) = env::var("HOME") {
        set_global!(("undodir", format!("{home}/.cache/nvim/undodir")));
    } else {
        api::notify(
            "[vimetal] no $HOME defined, can't set 'undodir'.",
            LogLevel::Warn,
            &NotifyOpts::default(),
        )?;
    }

    set_global!(
        ("nu", true),
        ("nuw", 2),
        ("hlsearch", false),
        ("relativenumber", true),
        ("tabstop", 2),
        ("softtabstop", 2),
        ("shiftwidth", 2),
        ("expandtab", true),
        ("smartindent", true),
        ("wrap", false),
        ("termguicolors", true),
        ("scrolloff", 10),
        ("sidescrolloff", 10),
        ("updatetime", 1000),
        ("completeopt", "menuone,noselect"),
        ("undofile", true)
    );

    Ok(())
}
