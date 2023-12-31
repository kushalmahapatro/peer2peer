// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.82.4.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty, unnecessary_const

import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';

import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';
import 'bridge_generated.io.dart' if (dart.library.html) 'bridge_generated.web.dart';

abstract class Peer2Peer {
  Future<void> dummy({required LogEntry a, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kDummyConstMeta;

  Future<String> rustSetUp({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kRustSetUpConstMeta;

  Stream<LogEntry> createLogStream({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kCreateLogStreamConstMeta;

  Future<String> printHello({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kPrintHelloConstMeta;

  Future<int> add({required int a, required int b, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kAddConstMeta;

  Future<int> subtract({required int a, required int b, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSubtractConstMeta;

  Future<String> getIpOne({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kGetIpOneConstMeta;

  Stream<int> tick({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kTickConstMeta;

  Future<String> startP2P({String? address, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kStartP2PConstMeta;
}

class LogEntry {
  final int timeMillis;
  final int level;
  final String tag;
  final String userId;
  final String user;
  final String msg;

  const LogEntry({
    required this.timeMillis,
    required this.level,
    required this.tag,
    required this.userId,
    required this.user,
    required this.msg,
  });
}

class Peer2PeerImpl implements Peer2Peer {
  final Peer2PeerPlatform _platform;
  factory Peer2PeerImpl(ExternalLibrary dylib) => Peer2PeerImpl.raw(Peer2PeerPlatform(dylib));

  /// Only valid on web/WASM platforms.
  factory Peer2PeerImpl.wasm(FutureOr<WasmModule> module) => Peer2PeerImpl(module as ExternalLibrary);
  Peer2PeerImpl.raw(this._platform);
  Future<void> dummy({required LogEntry a, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_log_entry(a);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_dummy(port_, arg0),
      parseSuccessData: _wire2api_unit,
      parseErrorData: null,
      constMeta: kDummyConstMeta,
      argValues: [
        a
      ],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kDummyConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "dummy",
        argNames: [
          "a"
        ],
      );

  Future<String> rustSetUp({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_rust_set_up(port_),
      parseSuccessData: _wire2api_String,
      parseErrorData: null,
      constMeta: kRustSetUpConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kRustSetUpConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "rust_set_up",
        argNames: [],
      );

  Stream<LogEntry> createLogStream({dynamic hint}) {
    return _platform.executeStream(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_create_log_stream(port_),
      parseSuccessData: _wire2api_log_entry,
      parseErrorData: _wire2api_FrbAnyhowException,
      constMeta: kCreateLogStreamConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kCreateLogStreamConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "create_log_stream",
        argNames: [],
      );

  Future<String> printHello({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_print_hello(port_),
      parseSuccessData: _wire2api_String,
      parseErrorData: null,
      constMeta: kPrintHelloConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kPrintHelloConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "print_hello",
        argNames: [],
      );

  Future<int> add({required int a, required int b, dynamic hint}) {
    var arg0 = api2wire_i32(a);
    var arg1 = api2wire_i32(b);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_add(port_, arg0, arg1),
      parseSuccessData: _wire2api_i32,
      parseErrorData: null,
      constMeta: kAddConstMeta,
      argValues: [
        a,
        b
      ],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kAddConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "add",
        argNames: [
          "a",
          "b"
        ],
      );

  Future<int> subtract({required int a, required int b, dynamic hint}) {
    var arg0 = api2wire_i32(a);
    var arg1 = api2wire_i32(b);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_subtract(port_, arg0, arg1),
      parseSuccessData: _wire2api_i32,
      parseErrorData: null,
      constMeta: kSubtractConstMeta,
      argValues: [
        a,
        b
      ],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kSubtractConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "subtract",
        argNames: [
          "a",
          "b"
        ],
      );

  Future<String> getIpOne({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_get_ip_one(port_),
      parseSuccessData: _wire2api_String,
      parseErrorData: _wire2api_FrbAnyhowException,
      constMeta: kGetIpOneConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kGetIpOneConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "get_ip_one",
        argNames: [],
      );

  Stream<int> tick({dynamic hint}) {
    return _platform.executeStream(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_tick(port_),
      parseSuccessData: _wire2api_i32,
      parseErrorData: _wire2api_FrbAnyhowException,
      constMeta: kTickConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kTickConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "tick",
        argNames: [],
      );

  Future<String> startP2P({String? address, dynamic hint}) {
    var arg0 = _platform.api2wire_opt_String(address);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_start_p2p(port_, arg0),
      parseSuccessData: _wire2api_String,
      parseErrorData: _wire2api_FrbAnyhowException,
      constMeta: kStartP2PConstMeta,
      argValues: [
        address
      ],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kStartP2PConstMeta => const FlutterRustBridgeTaskConstMeta(
        debugName: "start_p2p",
        argNames: [
          "address"
        ],
      );

  void dispose() {
    _platform.dispose();
  }
// Section: wire2api

  FrbAnyhowException _wire2api_FrbAnyhowException(dynamic raw) {
    return FrbAnyhowException(raw as String);
  }

  String _wire2api_String(dynamic raw) {
    return raw as String;
  }

  int _wire2api_i32(dynamic raw) {
    return raw as int;
  }

  int _wire2api_i64(dynamic raw) {
    return castInt(raw);
  }

  LogEntry _wire2api_log_entry(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 6) throw Exception('unexpected arr length: expect 6 but see ${arr.length}');
    return LogEntry(
      timeMillis: _wire2api_i64(arr[0]),
      level: _wire2api_i32(arr[1]),
      tag: _wire2api_String(arr[2]),
      userId: _wire2api_String(arr[3]),
      user: _wire2api_String(arr[4]),
      msg: _wire2api_String(arr[5]),
    );
  }

  int _wire2api_u8(dynamic raw) {
    return raw as int;
  }

  Uint8List _wire2api_uint_8_list(dynamic raw) {
    return raw as Uint8List;
  }

  void _wire2api_unit(dynamic raw) {
    return;
  }
}

// Section: api2wire

@protected
int api2wire_i32(int raw) {
  return raw;
}

@protected
int api2wire_u8(int raw) {
  return raw;
}

// Section: finalizer
