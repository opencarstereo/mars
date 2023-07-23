import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/pages/home.dart';
import 'package:ui/pages/player.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Open Car Stereo',
        theme: ThemeData.dark(useMaterial3: false),
        routes: {
          '/': (context) => const HomePage(),
          '/player': (context) => const PlayerPage(),
        },
      ),
    );
  }
}
