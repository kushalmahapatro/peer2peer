use crate::logger;
use anyhow;
use flutter_rust_bridge::StreamSink;
use futures::executor::block_on;
use futures::prelude::*;
use libp2p::{noise, ping, swarm::SwarmEvent, tcp, yamux, Multiaddr};
use log::{debug, info, trace, warn};
use std::thread::sleep;
use std::{error::Error, time::Duration};
use tokio::runtime::Runtime;
use tracing_subscriber::EnvFilter;

pub struct LogEntry {
    pub time_millis: i64,
    pub level: i32,
    pub tag: String,
    pub user_id: String,
    pub user: String,
    pub msg: String,
}

// Dummy function to fix Rust compiler complaints...
// See https://github.com/fzyzcjy/flutter_rust_bridge/issues/398
// Workaround:
// 1. Save Rust Code
// 2. Execute flutter_rust_bridge_codegen command
// 3. Make any change to Rust code (e.g. add blank) and save again
//    -> next compile is ok
#[allow(dead_code, unused_variables)]
pub fn dummy(a: LogEntry) {}

pub fn rust_set_up() -> String {
    logger::init_logger();
    "Logger was initialized".into()
}

pub fn create_log_stream(s: StreamSink<LogEntry>) -> anyhow::Result<()> {
    logger::SendToDartLogger::set_stream_sink(s);
    Ok(())
}

pub fn print_hello() -> String {
    info!("Hello from Rust! 🦀");
    String::from("Hello from Rust! 🦀")
}

pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

pub fn subtract(a: i32, b: i32) -> i32 {
    a - b
}

pub fn get_ip_one() -> anyhow::Result<String> {
    let runtime = Runtime::new().unwrap();
    runtime.block_on(async {
        let client = reqwest::Client::new();
        let res = client
            .get("https://api.ipify.org?format=json")
            .header("Accept", "application/json")
            .send()
            .await?
            .text()
            .await?;
        warn!("{:}", res);

        Ok(res)
    })
}

const ONE_SECOND: Duration = Duration::from_secs(1);

// can't omit the return type yet, this is a bug
pub fn tick(sink: StreamSink<i32>) -> anyhow::Result<()> {
    let mut ticks = 0;
    loop {
        sink.add(ticks);
        sleep(ONE_SECOND);
        if ticks == 60 {
            break;
        }
        ticks += 1;
    }
    Ok(())
}

pub fn start_p2p(address: Option<String>) -> anyhow::Result<String> {
    block_on(async {
        let _ = start_new_connection(address);
        debug!("Starting p2p");
        Ok("Starting p2p".parse()?)
    })
}

// #[tokio::main(flavor = "current_thread")]
#[tokio::main]
async fn start_new_connection(address: Option<String>) -> anyhow::Result<(), Box<dyn Error>> {
    debug!("{:}", "Starting p2p -2");

    let _ = tracing_subscriber::fmt()
        .with_env_filter(EnvFilter::from_default_env())
        .try_init();

    let mut swarm = libp2p::SwarmBuilder::with_new_identity()
        .with_tokio()
        .with_tcp(
            tcp::Config::default(),
            noise::Config::new,
            yamux::Config::default,
        )?
        .with_behaviour(|_| ping::Behaviour::default())?
        .with_swarm_config(|cfg| cfg.with_idle_connection_timeout(Duration::from_secs(u64::MAX)))
        .build();

    // Tell the swarm to listen on all interfaces and a random, OS-assigned
    // port.
    swarm.listen_on("/ip4/0.0.0.0/tcp/0".parse()?)?;

    // Dial the peer identified by the multi-address given as the second
    // command-line argument, if any.
    // if let Some(addr) = std::env::args().nth(1) {
    if let Some(addr) = address {
        let remote: Multiaddr = addr.parse()?;
        swarm.dial(remote)?;
        debug!("Dialed {}", addr);
        println!("Dialed {addr}")
    }

    loop {
        match swarm.select_next_some().await {
            SwarmEvent::NewListenAddr { address, .. } => {
                println!("Listening on {address:?}");
                debug!("Listening on {address:?}")
            }
            SwarmEvent::Behaviour(event) => {
                println!("{event:?}");
                debug!("{event:?}")
            }
            _ => {}
        }
    }
}
