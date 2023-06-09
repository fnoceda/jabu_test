// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jabu_test/app/app.dart';
import 'package:jabu_test/app/router.dart';
import 'package:jabu_test/presentation/widgets/custom_app_bar.dart';
import 'package:jabu_test/presentation/widgets/detail_data_widget.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../app/mock_locator.dart';

class MockHttpClient extends Mock implements http.Client {
  Future<http.Response> gets(dynamic uri, {dynamic headers}) {
    super.noSuchMethod(Invocation.method(#get, [uri], {#headers: headers}));
    return Future.value(http.Response('', 200));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    AppNavigator.configureRoutes();
    LocatorWithInternet.setUpLocators();
    HttpOverrides.global = null;
    WidgetsFlutterBinding.ensureInitialized();
  });

  group('Home Page Widget Test > ', () {
    testWidgets('Normal Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(const MyApp(
          initialRoute: '/detail/1',
        ));

        await tester.pumpAndSettle();
        final detailPage = find.byKey(const ValueKey('DetailPage.key'));
        expect(detailPage, findsOneWidget); // navigate ok
        final appBar = find.byType(CustomAppBar);
        final dataCard = find.byType(Card);
        final detailData = find.byType(DetailDataWidget);
        final avatar = find.byType(CircleAvatar);

        expect(appBar, findsOneWidget);
        expect(detailData, findsOneWidget);
        expect(avatar, findsOneWidget);
        expect(dataCard, findsOneWidget);
      });
    });

    testWidgets('300 x 400 Screen', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(300, 400);
      tester.view.devicePixelRatio = 1.0;
      tester.view.viewInsets = FakeViewPadding.zero;
      tester.view.viewPadding = FakeViewPadding.zero;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetViewInsets);
      addTearDown(tester.view.resetViewPadding);

      await tester.runAsync(() async {
        await tester.pumpWidget(const MyApp(
          initialRoute: '/detail/1',
        ));

        await tester.pumpAndSettle();
        final detailPage = find.byKey(const ValueKey('DetailPage.key'));
        expect(detailPage, findsOneWidget); // navigate ok
        final appBar = find.byType(CustomAppBar);
        final dataCard = find.byType(Card);
        final detailData = find.byType(DetailDataWidget);
        final avatar = find.byType(CircleAvatar);

        expect(appBar, findsOneWidget);
        expect(detailData, findsOneWidget);
        expect(avatar, findsOneWidget);
        expect(dataCard, findsOneWidget);
      });
    });

    testWidgets('400 x 300 Screen', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 300);
      tester.view.devicePixelRatio = 1.0;
      tester.view.viewInsets = FakeViewPadding.zero;
      tester.view.viewPadding = FakeViewPadding.zero;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetViewInsets);
      addTearDown(tester.view.resetViewPadding);

      await tester.runAsync(() async {
        await tester.pumpWidget(const MyApp(
          initialRoute: '/detail/1',
        ));

        await tester.pumpAndSettle();
        final detailPage = find.byKey(const ValueKey('DetailPage.key'));
        expect(detailPage, findsOneWidget); // navigate ok
        final appBar = find.byType(CustomAppBar);
        final dataCard = find.byType(Card);
        final detailData = find.byType(DetailDataWidget);
        final avatar = find.byType(CircleAvatar);

        expect(appBar, findsOneWidget);
        expect(detailData, findsOneWidget);
        expect(avatar, findsOneWidget);
        expect(dataCard, findsOneWidget);
      });
    });
  });
}
