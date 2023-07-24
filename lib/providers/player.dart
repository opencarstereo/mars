import 'package:bluez/bluez.dart';
import 'package:dbus/dbus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerProvider = StreamProvider<String?>((ref) async* {
  final client = BlueZClient();
  await client.connect();
  final device = 'dev_' + client.devices[0].address.replaceAll(':', '_');

  final service = DBusClient.system();
  final object = DBusRemoteObject(
    service,
    name: 'org.bluez',
    path: DBusObjectPath(
      '/org/bluez/hci0/$device/player0',
    ),
  );

  final title = await object.getProperty('org.bluez.MediaPlayer1', 'Track');

  final test = title.asStringVariantDict()['Title']?.asString();
  yield test;

  await for (var _ in object.propertiesChanged) {
    final title = await object.getProperty('org.bluez.MediaPlayer1', 'Track');

    final test = title.asStringVariantDict()['Title']?.asString();
    yield test;
  }
});

final devicesProvider = StreamProvider((ref) async* {
  final client = BlueZClient();
  await client.connect();
  yield client.devices;
});
