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
import 'package:uikit/widgets/custom_list_view_widget.dart';

import '../../../app/mock_locator.dart';

class MockHttpClient extends Mock implements http.Client {
  Future<http.Response> gets(dynamic uri, {dynamic headers}) {
    super.noSuchMethod(Invocation.method(#get, [uri], {#headers: headers}));
    return Future.value(http.Response('', 200));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    AppNavigator.configureRoutes();
    LocatorWithInternet.setUpLocators();
    HttpOverrides.global = null;
    WidgetsFlutterBinding.ensureInitialized();
  });
  testWidgets('Home Page Widget Test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(const MyApp());
      final customListView = find.byType(CustomListView);
      await tester.pumpAndSettle();
      expect(customListView, findsOneWidget);

      final listTiles = find.byType(ListTile);
      await tester.tap(listTiles.first);
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
}
