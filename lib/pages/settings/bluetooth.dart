import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/providers/bluetooth.dart';

final _bluetoothDevicesProvider = FutureProvider.autoDispose((ref) async {
  final bluetooth = await ref.watch(bluetoothProvider.future);

  final devices = bluetooth.devices;
  final subAdd = bluetooth.deviceAdded.listen((d) => devices.add(d));
  final subDel = bluetooth.deviceRemoved.listen(
    (d) => devices.removeWhere((element) => element.address == d.address),
  );

  final adapter = bluetooth.adapters[0];

  await adapter.startDiscovery();
  await Future.delayed(const Duration(seconds: 5));
  await adapter.stopDiscovery();

  subAdd.cancel();
  subDel.cancel();

  return devices;
});

class BluetoothSettingsPage extends ConsumerWidget {
  const BluetoothSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(_bluetoothDevicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth settings'),
      ),
      body: devices.when(
        data: (data) => ListView.builder(
          itemBuilder: (context, i) => ListTile(
            title: Text(data[i].name),
            subtitle: Text(data[i].address),
          ),
          itemCount: data.length,
        ),
        error: (_, __) => const Text("Error"),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
