import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeProvider = StreamProvider.autoDispose<DateTime>((ref) async* {
  final now = DateTime.now();
  yield now;

  await Future.delayed(Duration(seconds: 60 - (now.second % 60)));
  yield DateTime.now();

  final timer = Timer.periodic(const Duration(minutes: 1), (_) {
    ref.state = AsyncValue.data(DateTime.now());
  });

  ref.onDispose(() => timer.cancel());
});
