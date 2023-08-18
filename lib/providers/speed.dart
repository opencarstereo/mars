import 'package:flutter_riverpod/flutter_riverpod.dart';

final speedProvider = StreamProvider<double>((ref) async* {
  yield 0;
  // TODO: Implement CAN Bus connection
});
