import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/models/player.dart';
import 'package:ui/providers/player.dart';

class PlayerPage extends ConsumerWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final player = ref.watch(playerProvider).value;

    return Scaffold(
      body: Column(
        children: [
          Text(
            player?.title ?? '--',
            style: theme.textTheme.headlineLarge,
          ),
          Text(
            player?.artist ?? '--',
            style: theme.textTheme.titleLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => ref.read(playerProvider.notifier).previous(),
                icon: const Icon(Icons.skip_previous),
              ),
              IconButton(
                onPressed: () {
                  if (player?.status == PlayerStatus.playing) {
                    ref.read(playerProvider.notifier).pause();
                  } else if (player?.status == PlayerStatus.paused ||
                      player?.status == PlayerStatus.stopped) {
                    ref.read(playerProvider.notifier).play();
                  }
                },
                icon: Icon(
                  player?.status == PlayerStatus.playing
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
              ),
              IconButton(
                onPressed: () => ref.read(playerProvider.notifier).next(),
                icon: const Icon(Icons.skip_next),
              ),
            ],
          )
        ],
      ),
    );
  }
}
