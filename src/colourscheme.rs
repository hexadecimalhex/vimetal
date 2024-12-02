use nvim_oxi::{
    api::{self, opts::SetHighlightOpts},
    mlua, Error,
};

pub fn setup() -> Result<(), Error> {
    let lua = mlua::lua();
    // NOTE: this is nice but the idea is to rely on as little direct calls as possible :thonk:
    lua.load(
        r#"
        vim.cmd [["colorscheme oxocarbon"]]
        "#,
    )
    .exec()?;

    disable_hl_background("Normal")?;
    disable_hl_background("NormalFloat")?;
    disable_hl_background("NormalNC")?;

    Ok(())
}

fn disable_hl_background(hl_name: &str) -> Result<(), api::Error> {
    api::set_hl(
        0,
        hl_name,
        &SetHighlightOpts::builder().background("none").build(),
    )
}
