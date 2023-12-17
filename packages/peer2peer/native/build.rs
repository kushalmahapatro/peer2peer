extern crate cc;

use lib_flutter_rust_bridge_codegen::{
    config_parse, frb_codegen, get_symbols_if_no_duplicates, RawOpts,
};
use walkdir::WalkDir;

const RUST_INPUT: &str = "src/api.rs";
const DART_OUTPUT: &str = "../lib/src/bridge_generated.dart";

const IOS_C_OUTPUT: &str = "../../flutter_peer2peer/ios/Classes/frb.h";
const IOS_EXM_C_OUTPUT: &str = "../../flutter_example/ios/Classes/frb.h";
const MACOS_C_OUTPUT_DIR: &str = "../../flutter_peer2peer/macos/Classes/";
const MACOS_EXM_C_OUTPUT_DIR: &str = "../../flutter_example/macos/Classes/";

fn main() {
    println!("cargo:rustc-link-lib=framework=SystemConfiguration");
    // Tell Cargo that if the input Rust code changes, rerun this build script
    println!("cargo:rerun-if-changed={}", RUST_INPUT);

    // Options for frb_codegen
    let raw_opts = RawOpts {
        rust_input: vec![RUST_INPUT.to_string()],
        dart_output: vec![DART_OUTPUT.to_string()],
        c_output: Some(vec![IOS_C_OUTPUT.to_string()]),
        extra_c_output_path: Some(vec![MACOS_C_OUTPUT_DIR.to_string()]),
        inline_rust: true,
        wasm: true,
        ..Default::default()
    };
    // END: abpxx6d04wxr

    // BEGIN: be15d9bcejpp
    // Generate Rust & Dart ffi bridges
    let configs = config_parse(raw_opts);
    let all_symbols = get_symbols_if_no_duplicates(&configs).unwrap();
    for config in configs.iter() {
        frb_codegen(config, &all_symbols).unwrap();
    }

    // Format the generated Dart code
    std::process::Command::new("flutter")
        .arg("format")
        .arg("..")
        .spawn()
        .expect("Failed to format the generated Dart code");
    // END: be15d9bcejpp

    // BEGIN: Copy IOS_C_OUTPUT file
    std::fs::copy(IOS_C_OUTPUT, IOS_EXM_C_OUTPUT).expect("Failed to copy IOS_C_OUTPUT file");
    // END: Copy IOS_C_OUTPUT file

    // Copy MACOS_C_OUTPUT directory
    let src = std::path::Path::new(MACOS_C_OUTPUT_DIR);
    let dst = std::path::Path::new(MACOS_EXM_C_OUTPUT_DIR);
    copy_dir_to(&src, &dst).expect("Failed to copy MACOS_C_OUTPUT directory");
}

fn copy_dir_to(src: &std::path::Path, dst: &std::path::Path) -> std::io::Result<()> {
    if !dst.is_dir() {
        std::fs::create_dir_all(dst)?;
    }

    let _for_each = WalkDir::new(src).into_iter().for_each(|entry| {
        let entry = entry.expect("Failed to read directory entry");
        let src_path = entry.path();
        let dst_path = dst.join(src_path.strip_prefix(src).expect("Failed to strip prefix"));
        if src_path.is_dir() {
            std::fs::create_dir_all(&dst_path).expect("Failed to create directory");
        } else {
            std::fs::copy(&src_path, &dst_path).expect("Failed to copy file");
        }
    });
    Ok(())
}
