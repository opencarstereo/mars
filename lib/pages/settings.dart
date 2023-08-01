import 'dart:io';

import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Bluetooth'),
            subtitle: const Text('View and manage bluetooth devices'),
            onTap: () => Navigator.pushNamed(context, '/settings/bluetooth'),
          ),
          ListTile(
            title: const Text('Debug'),
            subtitle: const Text('Super secret settings page'),
            onTap: () => Navigator.pushNamed(context, '/settings/debug'),
          ),
          ListTile(
            title: const Text('Exit'),
            subtitle: const Text('Quit from mars and return to tty'),
            onTap: () => exit(0),
          )
        ],
      ),
    );
  }
}
