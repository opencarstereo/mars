import 'package:flutter/material.dart';

class ConfirmDeviceDialog extends StatelessWidget {
  final String name;
  final String pin;

  const ConfirmDeviceDialog({
    required this.name,
    required this.pin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Text('Confirm connection'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            pin,
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 24),
          Text(
            "$name wants to connect to this device. Check that the pairing code is the same on the other device",
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Pair'),
        ),
      ],
    );
  }
}
