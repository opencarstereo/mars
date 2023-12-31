import 'package:flutter/material.dart';
import 'package:ui/common/fake_pixel_ratio.dart';
import 'package:ui/common/status_bar.dart';
import 'package:ui/common/volume_slider.dart';
import 'package:ui/pages/home.dart';
import 'package:ui/pages/settings.dart';
import 'package:ui/pages/settings/bluetooth.dart';
import 'package:ui/pages/settings/debug.dart';
import 'package:ui/providers/bluetooth.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FakeDevicePixelRatio(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Open Car Stereo',
        theme: ThemeData.dark(useMaterial3: false),
        routes: {
          '/': (context) => const HomePage(),
          '/settings': (context) => const SettingsPage(),
          '/settings/bluetooth': (context) => const BluetoothSettingsPage(),
          '/settings/debug': (context) => const DebugSettingsPage(),
        },
        builder: (context, child) {
          // Flutter place the builder on top of the Overlay witget, so it can't
          // be reached from up here.
          return Scaffold(
            appBar: const StatusBar(),
            body: CheckedModeBanner(
              child: Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) => VolumeListenerOverlay(child: child!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
