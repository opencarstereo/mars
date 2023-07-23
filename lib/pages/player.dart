import 'package:flutter/material.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Test Song',
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
