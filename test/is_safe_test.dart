import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_safe/is_safe.dart';

void main() {
  const MethodChannel channel = MethodChannel('is_safe');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('isSafe', () async {
    expect(await IsSafe.isSafe, true);
  });
}
