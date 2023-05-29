// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jabu_test_bloc/app.dart';
import 'package:jabu_test_bloc/router.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'mock_locator.dart';

class MockHttpClient extends Mock implements http.Client {
  Future<http.Response> gets(dynamic uri, {dynamic headers}) {
    super.noSuchMethod(Invocation.method(#get, [uri], {#headers: headers}));
    return Future.value(http.Response('', 200));
  }
}

void main() {
  setUp(() {
    // await initHiveForFlutter();
    AppNavigator.configureRoutes();
    MockGetItWithInternet.setUpLocators();
    HttpOverrides.global = null;
    WidgetsFlutterBinding.ensureInitialized();
  });
  testWidgets('Home Page Widget Test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(const MyApp());

      final scafoldHome = find.byKey(const ValueKey('ScafoldHomePage.Key'));
      expect(scafoldHome, findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}
