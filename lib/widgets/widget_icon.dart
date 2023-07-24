import 'package:flutter/material.dart';

class WidgetIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const WidgetIcon({required this.icon, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Colors.white24,
          width: 2.0,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5.0),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Icon(
            icon,
            size: 64,
          ),
        ),
      ),
    );
  }
}
