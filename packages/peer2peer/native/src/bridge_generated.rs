#![allow(
    non_camel_case_types,
    unused,
    clippy::redundant_closure,
    clippy::useless_conversion,
    clippy::unit_arg,
    clippy::double_parens,
    non_snake_case,
    clippy::too_many_arguments
)]
// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.82.4.

use crate::api::*;
use core::panic::UnwindSafe;
use flutter_rust_bridge::rust2dart::IntoIntoDart;
use flutter_rust_bridge::*;
use std::ffi::c_void;
use std::sync::Arc;

// Section: imports

// Section: wire functions

fn wire_print_hello_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "print_hello",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Result::<_, ()>::Ok(print_hello()),
    )
}
fn wire_add_impl(
    port_: MessagePort,
    a: impl Wire2Api<i32> + UnwindSafe,
    b: impl Wire2Api<i32> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, i32, _>(
        WrapInfo {
            debug_name: "add",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_a = a.wire2api();
            let api_b = b.wire2api();
            move |task_callback| Result::<_, ()>::Ok(add(api_a, api_b))
        },
    )
}
fn wire_subtract_impl(
    port_: MessagePort,
    a: impl Wire2Api<i32> + UnwindSafe,
    b: impl Wire2Api<i32> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, i32, _>(
        WrapInfo {
            debug_name: "subtract",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_a = a.wire2api();
            let api_b = b.wire2api();
            move |task_callback| Result::<_, ()>::Ok(subtract(api_a, api_b))
        },
    )
}
// Section: wrapper structs

// Section: static checks

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

pub trait Wire2Api<T> {
    fn wire2api(self) -> T;
}

impl<T, S> Wire2Api<Option<T>> for *mut S
where
    *mut S: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        (!self.is_null()).then(|| self.wire2api())
    }
}
impl Wire2Api<i32> for i32 {
    fn wire2api(self) -> i32 {
        self
    }
}
// Section: impl IntoDart

// Section: executor

support::lazy_static! {
    pub static ref FLUTTER_RUST_BRIDGE_HANDLER: support::DefaultHandler = Default::default();
}

/// cbindgen:ignore
#[cfg(target_family = "wasm")]
mod web {
    use super::*;
    // Section: wire functions

    #[wasm_bindgen]
    pub fn wire_print_hello(port_: MessagePort) {
        wire_print_hello_impl(port_)
    }

    #[wasm_bindgen]
    pub fn wire_add(port_: MessagePort, a: i32, b: i32) {
        wire_add_impl(port_, a, b)
    }

    #[wasm_bindgen]
    pub fn wire_subtract(port_: MessagePort, a: i32, b: i32) {
        wire_subtract_impl(port_, a, b)
    }

    // Section: allocate functions

    // Section: related functions

    // Section: impl Wire2Api

    // Section: impl Wire2Api for JsValue

    impl<T> Wire2Api<Option<T>> for JsValue
    where
        JsValue: Wire2Api<T>,
    {
        fn wire2api(self) -> Option<T> {
            (!self.is_null() && !self.is_undefined()).then(|| self.wire2api())
        }
    }
    impl Wire2Api<i32> for JsValue {
        fn wire2api(self) -> i32 {
            self.unchecked_into_f64() as _
        }
    }
}
#[cfg(target_family = "wasm")]
pub use web::*;

#[cfg(not(target_family = "wasm"))]
mod io {
    use super::*;
    // Section: wire functions

    #[no_mangle]
    pub extern "C" fn wire_print_hello(port_: i64) {
        wire_print_hello_impl(port_)
    }

    #[no_mangle]
    pub extern "C" fn wire_add(port_: i64, a: i32, b: i32) {
        wire_add_impl(port_, a, b)
    }

    #[no_mangle]
    pub extern "C" fn wire_subtract(port_: i64, a: i32, b: i32) {
        wire_subtract_impl(port_, a, b)
    }

    // Section: allocate functions

    // Section: related functions

    // Section: impl Wire2Api

    // Section: wire structs

    // Section: impl NewWithNullPtr

    pub trait NewWithNullPtr {
        fn new_with_null_ptr() -> Self;
    }

    impl<T> NewWithNullPtr for *mut T {
        fn new_with_null_ptr() -> Self {
            std::ptr::null_mut()
        }
    }

    // Section: sync execution mode utility

    #[no_mangle]
    pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
        unsafe {
            let _ = support::box_from_leak_ptr(ptr);
        };
    }
}
#[cfg(not(target_family = "wasm"))]
pub use io::*;
