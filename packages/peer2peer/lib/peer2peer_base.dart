import 'dart:ffi';
import 'dart:io';

import 'package:peer2peer/src/bridge_generated.dart';
import 'package:peer2peer/src/ffi.dart';

class Peer2PeerLib {
  static Peer2PeerLib? _peer2peer;
  static late final Peer2Peer _lib;

  static Peer2PeerLib ensureInitialized() {
    _peer2peer = Peer2PeerLib._internal(isDart: false);
    return _peer2peer!;
  }

  static Peer2PeerLib ensureInitializedForDart([String? libPath]) {
    _peer2peer = Peer2PeerLib._internal(libPath: libPath);
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
