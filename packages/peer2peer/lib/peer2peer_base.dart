import 'dart:ffi';
import 'dart:io';

import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:logger/logger.dart';
import 'package:peer2peer/src/bridge_generated.dart';
import 'package:peer2peer/src/ffi.dart';

class Peer2PeerLib {
  static Peer2PeerLib? _peer2peer;
  static late final Peer2Peer _lib;

  static late final Logger _logger;
  static Peer2PeerLib ensureInitialized({Logger? logger}) {
    _peer2peer = Peer2PeerLib._internal(isDart: false);
    _logger = logger ?? Logger(printer: PrettyPrinter());
    return _peer2peer!;
  }

  static Peer2PeerLib ensureInitializedForDart([String? libPath]) {
    _peer2peer = Peer2PeerLib._internal(libPath: libPath);
    _logger = Logger(printer: PrettyPrinter());
    return _peer2peer!;
  }

  static Peer2Peer get instance {
    if (_peer2peer == null) {
      throw Exception(
        'Peer2Peer is not initialized, Please call ensureInitialized() first.',
      );
    }

    return _lib;
  }

  Peer2PeerLib._internal({String? libPath, bool isDart = true}) {
    const base = 'peer2peer';
    if (_peer2peer == null) {
      if (isDart) {
        _lib = createWrapper(_loadLibForDart(libPath ?? ''));
      } else {
        final path = Platform.isWindows ? '$base.dll' : 'lib$base.so';
        _lib = createWrapper(_loadLibForFlutter(path));
      }
    }
    _lib.rustSetUp().then((value) => _logger.d('RUST SETUP DONE $value'));
    _lib.createLogStream().listen((event) {
      _logger.log(
        event.level.logLevel,
        event.msg,
        time: DateTime.fromMillisecondsSinceEpoch(event.timeMillis),
      );
    });
  }

  /// load dynamic library
  DynamicLibrary _loadLibForFlutter(String path) {
    if (Platform.isIOS) {
      return DynamicLibrary.process();
    } else {
      if (Platform.isMacOS) {
        if (Abi.current() == Abi.macosX64) {
          return DynamicLibrary.executable();
        } else if (Abi.current() == Abi.macosArm64) {
          return DynamicLibrary.process();
        } else {
          return DynamicLibrary.open(path);
        }
      } else {
        return DynamicLibrary.open(path);
      }
    }
  }

  /// load dynamic library for dart
  DynamicLibrary _loadLibForDart(String path) =>
      Platform.isIOS ? DynamicLibrary.process() : DynamicLibrary.open(path);
}

extension P2PExt on Object? {
  String get p2pError {
    if (this is Exception) {
      return (this as Exception).toString();
    } else if (this is Error) {
      return (this as Error).toString();
    } else if (this is FrbAnyhowException) {
      return (this as FrbAnyhowException).anyhow;
    } else if (this is PanicException) {
      return (this as PanicException).error;
    }

    return toString();
  }
}

extension IntExt on int {
  Level get logLevel => switch (this) {
        5000 => Level.trace,
        10000 => Level.debug,
        20000 => Level.info,
        30000 => Level.warning,
        40000 => Level.error,
        _ => Level.info,
      };
}
