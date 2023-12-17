extern crate peer2peer_lib;

use peer2peer_lib::api;

pub fn main() {
    let _ = api::start_p2p(None);
}
