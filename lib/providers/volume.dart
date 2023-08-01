import 'package:flutter_riverpod/flutter_riverpod.dart';

final volumeProvider = NotifierProvider<VolumeNotifier, double>(
  () => VolumeNotifier(),
);

// TODO: Implement volume logic. This will be implemented with the car CAN bus
class VolumeNotifier extends Notifier<double> {
  @override
  double build() {
    return 0.7;
  }

  void updateVolume() {
    state = (state + 0.1) % 1;
  }
}
