import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';

final volumeProvider = NotifierProvider<VolumeNotifier, double>(
  () => VolumeNotifier(0.0),
);

class VolumeNotifier extends Notifier<double> {
  late StreamSubscription<double> _subscription;
  final double _initVolume;

  VolumeNotifier(this._initVolume);

  @override
  double build() {
    _subscription = FlutterVolumeController.addListener(
      (v) => state = v,
    );
    ref.onDispose(_dispose);

    return _initVolume;
  }

  void _dispose() {
    _subscription.cancel();
  }

  void updateVolume() {
    FlutterVolumeController.raiseVolume(0.1);
  }
}
