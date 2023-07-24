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
    final track = data['Track']!.asStringVariantDict();
    final title = track['Title']!.asString();
    final artist = track['Artist']!.asString();
    final status = data['Status']!.asString();

    return Player(
      title: title,
      artist: artist,
      status: PlayerStatus.values.byName(status),
    );
  }
}

enum PlayerStatus { playing, stopped, paused, error }
