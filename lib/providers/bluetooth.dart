import 'dart:math';

import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/dialogs/confirm_device.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final bluetoothProvider = FutureProvider<BlueZClient>((ref) async {
  final client = BlueZClient();
  await client.connect();
  final agent = OCSAgent();
  await client.registerAgent(agent);
  await client.requestDefaultAgent();

  return client;
});

class OCSAgent extends BlueZAgent {
  final GlobalKey<NavigatorState> _navigatorKey;

  OCSAgent() : _navigatorKey = navigatorKey;

  int _generatePin() {
    final random = Random();
    return random.nextInt(9000) + 1000;
  }

  @override
  Future<BlueZAgentPinCodeResponse> requestPinCode(BlueZDevice device) async {
    final pin = _generatePin();
    print("Use pin $pin");
    return BlueZAgentPinCodeResponse.success('$pin');
  }

  @override
  Future<BlueZAgentResponse> displayPinCode(
      BlueZDevice device, String pinCode) async {
    print('DisplayPinCode: PinCode $pinCode');
    return BlueZAgentResponse.success();
  }

  @override
  Future<BlueZAgentPasskeyResponse> requestPasskey(BlueZDevice device) async {
    print("RequestPassKey");
    final pin = _generatePin();
    print("Use pin $pin");
    return BlueZAgentPasskeyResponse.success(pin);
  }

  @override
  Future<BlueZAgentResponse> displayPasskey(
      BlueZDevice device, int passkey, int entered) async {
    print('DisplayPasskey: $passkey');
    return BlueZAgentResponse.success();
  }

  @override
  Future<BlueZAgentResponse> requestConfirmation(
    BlueZDevice device,
    int passkey,
  ) async {
    print('Request connection with passkey $passkey');
    bool res = await showDialog(
      context: _navigatorKey.currentContext!,
      builder: (context) => ConfirmDeviceDialog(
        name: device.name,
        pin: "$passkey",
      ),
    );
    return res ? BlueZAgentResponse.success() : BlueZAgentResponse.rejected();
  }

  @override
  Future<BlueZAgentResponse> requestAuthorization(BlueZDevice device) async {
    print("requestAuthorization");
    return BlueZAgentResponse.success();
  }

  @override
  Future<BlueZAgentResponse> authorizeService(
    BlueZDevice device,
    BlueZUUID uuid,
  ) async {
    print("authorizeService");
    return BlueZAgentResponse.success();
  }
}
