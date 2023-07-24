import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/providers/bluetooth.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(bluetoothProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Car Stereo'),
      ),
      body: Column(
        children: [
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
    );
  }
}
