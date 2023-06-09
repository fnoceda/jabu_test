// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jabu_test/app/app.dart';
import 'package:jabu_test/app/router.dart';
import 'package:jabu_test/presentation/widgets/list_builder.dart';
import 'package:jabu_test/presentation/widgets/search_input.dart';
import 'package:jabu_test/presentation/widgets/search_type_widget.dart';
import 'package:jabu_test/presentation/widgets/status_filter_widget.dart';
import 'package:jabu_test/utils/enums.dart';
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
  setUpAll(() {
    AppNavigator.configureRoutes();
    LocatorWithInternet.setUpLocators();
    HttpOverrides.global = null;
    WidgetsFlutterBinding.ensureInitialized();
  });

  group('Home Page Widget Test > ', () {
    testWidgets('Normal Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(const MyApp());

        final scafoldHome = find.byKey(const ValueKey('ScafoldHomePage.Key'));
        final loadingText = find.byType(CupertinoActivityIndicator);
        final searchTypeWidget = find.byType(SearchTypeWidget);
        final searchInputWidget = find.byType(SearchInput);
        final statusFilterWidget = find.byType(StatusFilterWidget);
        final listBuilder = find.byType(ListBuilder);
        final customListView = find.byType(CustomListView);

        expect(scafoldHome, findsOneWidget);
        expect(loadingText, findsOneWidget);
        expect(searchTypeWidget, findsOneWidget);
        expect(searchInputWidget, findsOneWidget);
        expect(statusFilterWidget, findsOneWidget);
        expect(listBuilder, findsOneWidget);
        await tester.pumpAndSettle();

        expect(customListView, findsOneWidget);

        final searchInput2 = find.byKey(const Key('SearchKey'));
        // print(searchInput2);

        expect(searchInput2, findsOneWidget);

        await tester.enterText(searchInput2, 'Rick');
        await tester.pump();
        await Future.delayed(const Duration(milliseconds: 1000));
        await tester.pumpAndSettle();

        expect(find.text('Rick'), findsOneWidget);

        final radio = find.byType(Radio<SearchType>);
        await tester.tap(radio.last);
        await tester.pumpAndSettle();
        final radioWidgetSpecies = tester.widget<Radio<SearchType>>(radio.last);
        await tester.pump();
        expect(radioWidgetSpecies.groupValue, SearchType.species);

        await tester.tap(radio.first);
        await tester.pumpAndSettle();
        final radioWidgetName = tester.widget<Radio<SearchType>>(radio.first);
        expect(radioWidgetName.groupValue, SearchType.name);

        final segmentedButton = find.byType(SegmentedButton<DataFilter>);
        expect(segmentedButton, findsOneWidget);

        //scroll
        final firstItem = find.text('Name 0');
        expect(firstItem, findsWidgets);
        await tester.drag(find.byType(ListView), const Offset(0.0, -10000));
        await tester.pumpAndSettle();
        final lastItem = find.text('Name 19');
        expect(lastItem, findsWidgets);
        await tester.pump(const Duration(milliseconds: 500));

        // // navegacion
        final listTiles = find.byType(ListTile);
        await tester.tap(listTiles.last);
        await tester.pumpAndSettle();
        final detailPage = find.byKey(const ValueKey('DetailPage.key'));
        expect(detailPage, findsOneWidget);
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
        await tester.pumpWidget(const MyApp());

        final scafoldHome = find.byKey(const ValueKey('ScafoldHomePage.Key'));
        final loadingText = find.byType(CupertinoActivityIndicator);
        final searchTypeWidget = find.byType(SearchTypeWidget);
        final searchInputWidget = find.byType(SearchInput);
        final statusFilterWidget = find.byType(StatusFilterWidget);
        final listBuilder = find.byType(ListBuilder);
        final customListView = find.byType(CustomListView);

        expect(scafoldHome, findsOneWidget);
        expect(loadingText, findsOneWidget);
        expect(searchTypeWidget, findsOneWidget);
        expect(searchInputWidget, findsOneWidget);
        expect(statusFilterWidget, findsOneWidget);
        expect(listBuilder, findsOneWidget);
        await tester.pumpAndSettle();

        expect(customListView, findsOneWidget);

        final searchInput2 = find.byKey(const Key('SearchKey'));
        // print(searchInput2);

        expect(searchInput2, findsOneWidget);

        await tester.enterText(searchInput2, 'Rick');
        await tester.pump();
        await Future.delayed(const Duration(milliseconds: 1000));
        await tester.pumpAndSettle();

        expect(find.text('Rick'), findsOneWidget);

        final radio = find.byType(Radio<SearchType>);
        await tester.ensureVisible(radio.last);
        await tester.tap(radio.last);
        await tester.pumpAndSettle();
        final radioWidgetSpecies = tester.widget<Radio<SearchType>>(radio.last);
        await tester.pump();
        expect(radioWidgetSpecies.groupValue, SearchType.species);

        await tester.tap(radio.first);
        await tester.pumpAndSettle();
        final radioWidgetName = tester.widget<Radio<SearchType>>(radio.first);
        expect(radioWidgetName.groupValue, SearchType.name);

        final segmentedButton = find.byType(SegmentedButton<DataFilter>);
        expect(segmentedButton, findsOneWidget);

        // //scroll
        final firstItem = find.text('Name 0');
        expect(firstItem, findsWidgets);
        await tester.drag(find.byType(ListView), const Offset(0.0, -10000));
        await tester.pumpAndSettle();
        final lastItem = find.text('Name 19');
        expect(lastItem, findsWidgets);
        await tester.pump(const Duration(milliseconds: 500));

        // // // navegacion
        final listTiles = find.byType(ListTile);
        await tester.tap(listTiles.last);
        await tester.pumpAndSettle();
        final detailPage = find.byKey(const ValueKey('DetailPage.key'));
        expect(detailPage, findsOneWidget);
      });
    });
  });
}
