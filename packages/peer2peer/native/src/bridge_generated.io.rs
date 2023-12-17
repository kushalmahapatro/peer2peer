use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_dummy(port_: i64, a: *mut wire_LogEntry) {
    wire_dummy_impl(port_, a)
}

#[no_mangle]
pub extern "C" fn wire_rust_set_up(port_: i64) {
    wire_rust_set_up_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_create_log_stream(port_: i64) {
    wire_create_log_stream_impl(port_)
}

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

#[no_mangle]
pub extern "C" fn wire_get_ip_one(port_: i64) {
    wire_get_ip_one_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_tick(port_: i64) {
    wire_tick_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_start_p2p(port_: i64, address: *mut wire_uint_8_list) {
    wire_start_p2p_impl(port_, address)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_box_autoadd_log_entry_0() -> *mut wire_LogEntry {
    support::new_leak_box_ptr(wire_LogEntry::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}
impl Wire2Api<LogEntry> for *mut wire_LogEntry {
    fn wire2api(self) -> LogEntry {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<LogEntry>::wire2api(*wrap).into()
    }
}

impl Wire2Api<LogEntry> for wire_LogEntry {
    fn wire2api(self) -> LogEntry {
        LogEntry {
            time_millis: self.time_millis.wire2api(),
            level: self.level.wire2api(),
            tag: self.tag.wire2api(),
            user_id: self.user_id.wire2api(),
            user: self.user.wire2api(),
            msg: self.msg.wire2api(),
        }
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_LogEntry {
    time_millis: i64,
    level: i32,
    tag: *mut wire_uint_8_list,
    user_id: *mut wire_uint_8_list,
    user: *mut wire_uint_8_list,
    msg: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

impl NewWithNullPtr for wire_LogEntry {
    fn new_with_null_ptr() -> Self {
        Self {
            time_millis: Default::default(),
            level: Default::default(),
            tag: core::ptr::null_mut(),
            user_id: core::ptr::null_mut(),
            user: core::ptr::null_mut(),
            msg: core::ptr::null_mut(),
        }
    }
}

impl Default for wire_LogEntry {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
    unsafe {
        let _ = support::box_from_leak_ptr(ptr);
    };
}
