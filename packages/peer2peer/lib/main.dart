import 'package:peer2peer/peer2peer.dart';
import 'package:test/test.dart';

const isWeb = bool.fromEnvironment('dart.library.html');

String? skipWeb([String reason = 'unspecified']) =>
    isWeb ? 'Skipped on web (reason: $reason)' : null;

void main(List<String> args) async {
  String dylibPath = args.first;
  var releaseMode = true;
  assert(() {
    releaseMode = false;
    return true;
  }());
  Peer2PeerLib.ensureInitializedForDart(dylibPath);

  final p2pApi = Peer2PeerLib.instance;

  test('dart call print', () async {
    expect(await p2pApi.printHello(), 'Hello from Rust! 🦀');
  });

  test('dart call simpleAdder', () async {
    expect(await p2pApi.add(a: 3, b: 11), 14);
  });

  test('dart call simple Subtract', () async {
    expect(await p2pApi.subtract(a: 3, b: 11), -8);
  });
}
