import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            player ?? '--',
            style: theme.textTheme.headlineLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.skip_previous),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.pause),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.skip_next),
              ),
            ],
          )
        ],
      ),
    );
  }
}
