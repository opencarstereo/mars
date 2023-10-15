import 'dart:async';

import 'package:dbus/dbus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/models/player.dart';
import 'package:ui/providers/logger.dart';

final playerProvider = AsyncNotifierProvider<PlayerNotifier, Player?>(() {
  return PlayerNotifier();
});

class PlayerNotifier extends AsyncNotifier<Player?> {
  late DBusRemoteObject _object;
  StreamSubscription<DBusPropertiesChangedSignal>? _subscription;

  Future<Player?> _getState() async {
    try {
      final player = await _object.getAllProperties(
        'org.mpris.MediaPlayer2.Player',
      );
      return Player.fromDBus(player);
    } catch (e) {
      ref.read(loggerProvider).e(e);
      ref.read(loggerProvider).w("No player found");
      return null;
    }
  }

  @override
  Future<Player?> build() async {
    ref.onDispose(_dispose);

    final service = DBusClient.session();

    _object = DBusRemoteObject(
      service,
      name: 'org.mpris.MediaPlayer2.playerctld',
      path: DBusObjectPath(
        '/org/mpris/MediaPlayer2',
      ),
    );

    _subscription = _object.propertiesChanged.listen((_) async {
      state = await AsyncValue.guard(() => _getState());
    });

    return _getState();
  }

  void _dispose() {
    _subscription?.cancel();
  }

  Future<void> pause() {
    return _object.callMethod('org.mpris.MediaPlayer2.Player', 'Pause', {});
  }

  Future<void> play() {
    return _object.callMethod('org.mpris.MediaPlayer2.Player', 'Play', {});
  }

  Future<void> previous() {
    return _object.callMethod('org.mpris.MediaPlayer2.Player', 'Previous', {});
  }

  Future<void> next() {
    return _object.callMethod('org.mpris.MediaPlayer2.Player', 'Next', {});
  }
}
