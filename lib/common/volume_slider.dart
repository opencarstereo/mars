import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/providers/volume.dart';

class VolumeListenerOverlay extends ConsumerStatefulWidget {
  final Widget child;

  const VolumeListenerOverlay({
    required this.child,
    super.key,
  });

  @override
  VolumeListenerOverlayState createState() => VolumeListenerOverlayState();
}

class VolumeListenerOverlayState extends ConsumerState<VolumeListenerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  OverlayEntry? _currentOverlay;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.read(volumeProvider);
    ref.listen(
      volumeProvider,
      (_, volume) => showOverlay(volume),
    );

    return widget.child;
  }

  void showOverlay(double value) {
    closeOverlay();

    _currentOverlay = OverlayEntry(
      builder: (context) => VolumeSlider(
        value: value,
        onClose: closeOverlay,
        controller: _controller,
      ),
    );
    Overlay.of(context).insert(_currentOverlay!);
  }

  void closeOverlay() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}

class VolumeSlider extends StatefulWidget {
  final double value;
  final VoidCallback? onClose;
  final AnimationController controller;

  const VolumeSlider({
    required this.value,
    required this.controller,
    this.onClose,
    super.key,
  });

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  late Animation<double> positionAnimation;

  @override
  void initState() {
    super.initState();
    positionAnimation = Tween<double>(
      begin: -64,
      end: 24,
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: Curves.easeOut,
    ));
    widget.controller.forward();

    Future.delayed(const Duration(seconds: 5), close);
  }

  Future<void> close() async {
    await widget.controller.reverse();
    widget.onClose?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: positionAnimation,
      builder: (context, child) {
        return Positioned(
          top: positionAnimation.value,
          left: 0,
          right: 0,
          child: child!,
        );
      },
      child: UnconstrainedBox(
        child: Container(
          width: 310,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.volume_up,
                color: Colors.black,
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: CustomPaint(
                  painter: _VolumePainter(widget.value),
                  child: Container(),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _VolumePainter extends CustomPainter {
  final double volume;

  const _VolumePainter(this.volume);

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width * volume;
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    // Trace
    canvas.drawLine(
      Offset.zero,
      Offset(size.width, 0),
      paint..color = Colors.black26,
    );
    // Thumb
    canvas.drawLine(
      Offset.zero,
      Offset(width, 0),
      paint..color = Colors.blue.shade400,
    );
  }

  @override
  bool shouldRepaint(_VolumePainter oldDelegate) =>
      oldDelegate.volume != volume;

  @override
  bool shouldRebuildSemantics(_VolumePainter oldDelegate) => false;
}
