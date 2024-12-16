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

macro_rules! warning {
    ( $msg:expr ) => {
        nvim_oxi::api::notify(
            $msg,
            nvim_oxi::api::types::LogLevel::Warn,
            &nvim_oxi::api::opts::NotifyOpts::default(),
        ).ok();
    };
}

macro_rules! info {
    ( $msg:expr ) => {
        nvim_oxi::api::notify(
            $msg,
            nvim_oxi::api::types::LogLevel::Info,
            nvim_oxi::api::opts::NotifyOpts::default(),
        )
    };
}

pub(crate) use info;
pub(crate) use set_global;
pub(crate) use warning;
