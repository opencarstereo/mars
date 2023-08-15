import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:logger/logger.dart';
import 'package:ui/app.dart';
import 'package:args/args.dart';
import 'package:ui/providers/volume.dart';

void main(List<String> args) async {
  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', help: 'Shows this menu')
    ..addFlag(
      'verbose',
      abbr: 'v',
      help: 'Set the logging level to debug. On by default in debug mode',
    );
  final res = parser.parse(args);

  if (res['help'] as bool) {
    stdout.writeln(parser.usage);
    exit(0);
  }

  if (!res['verbose']) {
    Logger.level = Level.error;
  }

  if (kDebugMode) {
    Logger.level = Level.debug;
  }

  WidgetsFlutterBinding.ensureInitialized();
  final volume = await FlutterVolumeController.getVolume() ?? 0;

  runApp(ProviderScope(
    overrides: [
      volumeProvider.overrideWith(() => VolumeNotifier(volume)),
    ],
    child: const App(),
  ));
}
