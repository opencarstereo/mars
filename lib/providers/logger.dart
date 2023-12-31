import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final loggerProvider = Provider<Logger>(
  (ref) => Logger(
    filter: ProductionFilter(),
    printer: SimplePrinter(),
  ),
);
