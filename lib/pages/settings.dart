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
          )
        ],
      ),
    );
  }
}
