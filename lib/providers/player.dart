import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerProvider = StreamProvider<String?>((ref) async* {
  String? lastSong;

  while (true) {
    final process = await Process.run('playerctl', ['metadata', 'title']);
    final title = process.stdout;

    if (title != lastSong) {
      lastSong = title;
      yield lastSong;
    }
    await Future.delayed(const Duration(seconds: 3));
  }
});
