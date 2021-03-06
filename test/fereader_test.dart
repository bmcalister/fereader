import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fereader/fereader.dart';

void main() {
  const MethodChannel channel = MethodChannel('fereader');

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
