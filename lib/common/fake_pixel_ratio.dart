import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/providers/pixel_ratio.dart';

class FakeDevicePixelRatio extends ConsumerWidget {
  final Widget child;

  const FakeDevicePixelRatio({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fakeDevicePixelRatio = ref.watch(pixelRatioProvider);
    final ratio = fakeDevicePixelRatio / View.of(context).devicePixelRatio;

    return FractionallySizedBox(
      widthFactor: 1 / ratio,
      heightFactor: 1 / ratio,
      child: Transform.scale(
        scale: ratio,
        child: child,
      ),
    );
  }
}
