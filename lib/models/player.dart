import 'package:dbus/dbus.dart';

class Player {
  final String? title;
  final String? artist;
  final PlayerStatus status;

  Player({
    required this.title,
    required this.artist,
    required this.status,
  });

  factory Player.fromDBus(Map<String, DBusValue> data) {
    final metadata = data['Metadata']!.asStringVariantDict();
    final title = metadata['xesam:title']!.asString();
    final artist = metadata['xesam:artist']!.asStringArray().join(', ');
    final status = data['PlaybackStatus']!.asString();

    return Player(
      title: title,
      artist: artist,
      status: PlayerStatus.values.byName(status.toLowerCase()),
    );
  }
}

enum PlayerStatus { playing, stopped, paused, error }
