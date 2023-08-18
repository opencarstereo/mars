import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/providers/volume.dart';
import 'package:ui/widgets/player.dart';
import 'package:ui/widgets/speedometer.dart';
import 'package:ui/widgets/widget_icon.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          const Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 1,
                child: Center(
                  child: SizedBox(
                    width: 400,
                    height: 400,
                    child: SpeedometerWidget(),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: PlayerWidget(),
              )
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetIcon(
                icon: Icons.settings,
                onTap: () => Navigator.pushNamed(context, '/settings'),
              ),
              const SizedBox(
                width: 12,
              ),
              WidgetIcon(
                icon: Icons.volume_up,
                onTap: () => ref.read(volumeProvider.notifier).updateVolume(),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
