import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ui/providers/time.dart';

class TimeWidget extends ConsumerWidget {
  const TimeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider).value;

    if(time == null) return Container();
    return Text(DateFormat.Hm().format(time));
  }
}