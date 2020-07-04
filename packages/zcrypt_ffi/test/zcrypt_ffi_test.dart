import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zcrypt_ffi/zcrypt_ffi.dart';

void main() {
  const MethodChannel channel = MethodChannel('zcrypt_ffi');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
