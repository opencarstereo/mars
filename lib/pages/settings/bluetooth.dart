import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/providers/bluetooth.dart';
import 'package:ui/providers/logger.dart';

final _bluetoothDevicesProvider = StreamProvider.autoDispose<List<BlueZDevice>>(
  (ref) async* {
    final bluetooth = await ref.watch(bluetoothProvider.future);
    final logger = ref.read(loggerProvider);

    final adapter = bluetooth.adapters[0];

    await bluetooth.adapters[0].setDiscoverable(true);
    logger.i("[Bluetooth]: Device is now visible with name ${adapter.alias}");

    final devices = bluetooth.devices;

    final subAdd = bluetooth.deviceAdded.listen((d) {
      devices.add(d);
      ref.state = AsyncValue.data(devices);
    });
    final subDel = bluetooth.deviceRemoved.listen(
      (d) {
        devices.removeWhere((element) => element.address == d.address);
        ref.state = AsyncValue.data(devices);
      },
    );

    ref.onDispose(() async {
      if (adapter.discovering) await adapter.stopDiscovery();
      await adapter.setDiscoverable(false);
      logger.i("[Bluetooth]: Discovery of devices stopped");

      subAdd.cancel();
      subDel.cancel();
    });

    if (!adapter.discovering) {
      await adapter.startDiscovery();
      logger.i("[Bluetooth]: Started discovery of devices");
    } else {
      logger.w(
        "[Bluetooth]: Discovery of devices not started because was already running",
      );
    }

    yield devices;
  },
);

class BluetoothSettingsPage extends ConsumerWidget {
  const BluetoothSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(_bluetoothDevicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth settings'),
      ),
      body: Column(
        children: [
          Opacity(
            opacity: devices.hasValue ? 1 : 0,
            child: const LinearProgressIndicator(),
          ),
          devices.when(
            data: (data) => Expanded(
              child: ListView.builder(
                itemBuilder: (context, i) => ListTile(
                  onTap: () => data[i].pair(),
                  title: Text(
                    data[i].name,
                    style: TextStyle(
                      fontWeight: data[i].connected ? FontWeight.w600 : null,
                    ),
                  ),
                  subtitle: Text(data[i].address),
                ),
                itemCount: data.length,
              ),
            ),
            error: (e, s) => Text("Error: $e\n$s"),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
