import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ui/providers/time.dart';

class StatusBar extends ConsumerWidget implements PreferredSizeWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider).value;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
      decoration: const BoxDecoration(color: Color(0xFF161616)),
      child: Row(
        children: [
          const Spacer(),
          if (time != null)
            Text(
              DateFormat.Hm().format(time),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
