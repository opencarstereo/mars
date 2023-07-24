import 'package:bluez/bluez.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bluetoothProvider = FutureProvider<BlueZClient>((ref) async {
  final client = BlueZClient();
  await client.connect();
  return client;
});
