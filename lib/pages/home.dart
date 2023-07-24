import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/providers/bluetooth.dart';
import 'package:ui/widgets/player.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(bluetoothProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Car Stereo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const PlayerWidget(),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/player'),
              child: const Text('Player'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
