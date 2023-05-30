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
import 'package:jabu_test/presentation/widgets/list_builder.dart';
import 'package:jabu_test/presentation/widgets/search_input.dart';
import 'package:jabu_test/presentation/widgets/search_type_widget.dart';
import 'package:jabu_test/presentation/widgets/status_filter_widget.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:uikit/widgets/custom_list_view_widget.dart';

import '../../app/mock_locator.dart';

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
    LocatorWithOutInternet.setUpLocators();
    HttpOverrides.global = null;
    WidgetsFlutterBinding.ensureInitialized();
  });
  testWidgets('Home Page Widget Test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(const MyApp());

      final scafoldHome = find.byKey(const ValueKey('ScafoldHomePage.Key'));
      final loadingText = find.byKey(const ValueKey('Loading.Key'));
      final searchTypeWidget = find.byType(SearchTypeWidget);
      final searchInput = find.byType(SearchInput);
      final statusFilterWidget = find.byType(StatusFilterWidget);
      final listBuilder = find.byType(ListBuilder);
      final customListView = find.byType(CustomListView);

      expect(scafoldHome, findsOneWidget);
      expect(loadingText, findsOneWidget);
      expect(searchTypeWidget, findsOneWidget);
      expect(searchInput, findsOneWidget);
      expect(statusFilterWidget, findsOneWidget);
      expect(listBuilder, findsOneWidget);
      await tester.pumpAndSettle();

      expect(customListView, findsOneWidget);

      final listTiles = find.byType(ListTile);
      await tester.tap(listTiles.first);
      await tester.pumpAndSettle();
      final detailPage = find.byKey(const ValueKey('DetailPage.key'));
      expect(detailPage, findsOneWidget);
    });
  });
}
