import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/providers/pixel_ratio.dart';

class DebugSettingsPage extends ConsumerWidget {
  const DebugSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final pixelRatio = ref.watch(pixelRatioProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        children: [
          Text(
            'Pixel ratio',
            style: theme.textTheme.titleMedium,
          ),
          Slider(
            value: pixelRatio,
            divisions: 3,
            max: 2,
            min: 0.5,
            label: "$pixelRatio",
            onChanged: (v) => ref.read(pixelRatioProvider.notifier).state = v,
          ),
        ],
      ),
    );
  }
}
