import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jabu_test/app/app.dart';
import 'package:jabu_test/app/router.dart';

import '../../app/mock_locator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    AppNavigator.configureRoutes();
    LocatorWithInternet.setUpLocators();
    HttpOverrides.global = null;
    WidgetsFlutterBinding.ensureInitialized();
  });
  testWidgets('NotFoundPageTest', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(const MyApp(
        initialRoute: '/sbadroute',
      ));
      await tester.pumpAndSettle();
    });
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    final btn = find.byType(ElevatedButton);
    expect(btn, findsOneWidget);
    await tester.tap(btn);
    await tester.pumpAndSettle();

    // // navegacion
    final homePage = find.byKey(const ValueKey('ScafoldHomePage.Key'));
    expect(homePage, findsOneWidget);
  });
}
