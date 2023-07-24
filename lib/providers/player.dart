import 'package:bluez/bluez.dart';
import 'package:dbus/dbus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/models/player.dart';

final playerProvider = AsyncNotifierProvider<PlayerNotifier, Player>(() {
  return PlayerNotifier();
});

class PlayerNotifier extends AsyncNotifier<Player> {
  late DBusRemoteObject _object;

  Future<Player> _getState() async {
    final player = await _object.getAllProperties('org.bluez.MediaPlayer1');
    return Player.fromDBus(player);
  }

  @override
  Future<Player> build() async {
    // Handle device swap. This will break
    final client = BlueZClient();
    await client.connect();
    final device = 'dev_' + client.devices[0].address.replaceAll(':', '_');

    final service = DBusClient.system();
    _object = DBusRemoteObject(
      service,
      name: 'org.bluez',
      path: DBusObjectPath(
        '/org/bluez/hci0/$device/player0',
      ),
    );

    _object.propertiesChanged.listen((_) async {
      state = await AsyncValue.guard(() => _getState());
    });

    return _getState();
  }

  Future<void> pause() {
    return _object.callMethod('org.bluez.MediaPlayer1', 'Pause', {});
  }

  Future<void> play() {
    return _object.callMethod('org.bluez.MediaPlayer1', 'Play', {});
  }

  Future<void> previous() {
    return _object.callMethod('org.bluez.MediaPlayer1', 'Previous', {});
  }

  Future<void> next() {
    return _object.callMethod('org.bluez.MediaPlayer1', 'Next', {});
  }
}
