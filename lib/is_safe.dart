import 'dart:async';

import 'package:flutter/services.dart';

class IsSafe {
  static const MethodChannel _channel = MethodChannel('is_safe');

  static Future<bool> get isSafe async => await _channel.invokeMethod('isSafe');
}
