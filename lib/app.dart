import 'package:flutter/material.dart';
import 'package:ui/pages/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Car Stereo',
      theme: ThemeData.dark(useMaterial3: false),
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}
