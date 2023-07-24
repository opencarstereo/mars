import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/widgets/player.dart';
import 'package:ui/widgets/widget_icon.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Car Stereo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PlayerWidget(),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                WidgetIcon(
                  icon: Icons.settings,
                  onTap: () => Navigator.pushNamed(context, '/settings'),
                ),
                const SizedBox(
                  width: 12,
                ),
                WidgetIcon(
                  icon: Icons.music_note,
                  onTap: () => Navigator.pushNamed(context, '/player'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
