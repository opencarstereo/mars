import 'dart:math';

import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:ui/dialogs/confirm_device.dart';
import 'package:ui/providers/logger.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final bluetoothProvider = FutureProvider<BlueZClient>((ref) async {
  final logger = ref.read(loggerProvider);

  final client = BlueZClient();
  await client.connect();
  final agent = OCSAgent(logger: logger);

  await client.registerAgent(agent);
  await client.requestDefaultAgent();
  logger.i("[Bluetooth]: Registered custom agent");

  return client;
});

class OCSAgent extends BlueZAgent {
  final GlobalKey<NavigatorState> _navigatorKey;
  final Logger logger;

  OCSAgent({required this.logger}) : _navigatorKey = navigatorKey;

  int _generatePin() {
    final random = Random();
    return random.nextInt(9000) + 1000;
  }

  @override
  Future<BlueZAgentPinCodeResponse> requestPinCode(BlueZDevice device) async {
    final pin = _generatePin();
    logger
        .i("[OCSAgent]: ${device.address} requested pin for connection. $pin");
    return BlueZAgentPinCodeResponse.success('$pin');
  }

  @override
  Future<BlueZAgentResponse> displayPinCode(
    BlueZDevice device,
    String pinCode,
  ) async {
    logger.i("[OCSAgent]: ${device.address} sent pin for connection. $pinCode");
    return BlueZAgentResponse.success();
  }

  @override
  Future<BlueZAgentPasskeyResponse> requestPasskey(BlueZDevice device) async {
    final pin = _generatePin();
    logger.i(
      "[OCSAgent]: ${device.address} requested pass key for connection. $pin",
    );
    return BlueZAgentPasskeyResponse.success(pin);
  }

  @override
  Future<BlueZAgentResponse> displayPasskey(
    BlueZDevice device,
    int passkey,
    int entered,
  ) async {
    logger.i(
      "[OCSAgent]: ${device.address} sent pass key for connection: $passkey. Device sent: $entered",
    );
    return BlueZAgentResponse.success();
  }

  @override
  Future<BlueZAgentResponse> requestConfirmation(
    BlueZDevice device,
    int passkey,
  ) async {
    logger.i(
      '[OCSAgent]: ${device.address} requested connection with passkey $passkey',
    );

    bool res = await showDialog(
      context: _navigatorKey.currentContext!,
      builder: (context) => ConfirmDeviceDialog(
        name: device.name,
        pin: "$passkey",
      ),
    );

    logger.i(
      '[OCSAgent]: Connection with ${device.address} ${res ? 'accepted' : 'rejected'}',
    );
    return res ? BlueZAgentResponse.success() : BlueZAgentResponse.rejected();
  }

  @override
  Future<BlueZAgentResponse> requestAuthorization(BlueZDevice device) async {
    logger.i('[OCSAgent]: ${device.address} request authorization. Accepted');
    return BlueZAgentResponse.success();
  }

  @override
  Future<BlueZAgentResponse> authorizeService(
    BlueZDevice device,
    BlueZUUID uuid,
  ) async {
    logger.i('[OCSAgent]: ${device.address} requested service $uuid. Accepted');
    return BlueZAgentResponse.success();
  }
}
