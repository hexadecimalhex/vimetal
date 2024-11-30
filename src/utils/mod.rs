macro_rules! set_global {
    ( $( ($key:expr, $val:expr) ),+ ) => {
        $(
            nvim_oxi::api::set_option_value($key, $val,
                &nvim_oxi::api::opts::OptionOpts::builder()
                    .scope(nvim_oxi::api::opts::OptionScope::Global)
                    .build(),
            )?;
        )+
    }
}

pub(crate) use set_global;
