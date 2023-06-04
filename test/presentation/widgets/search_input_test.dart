import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jabu_test/app/router.dart';
import 'package:jabu_test/presentation/widgets/search_input.dart';
import 'package:mockito/mockito.dart';

import '../../app/mock_locator.dart';

abstract class MyFunction {
  void call(String value);
}

class MyFunctionMock extends Mock implements MyFunction {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    AppNavigator.configureRoutes();
    LocatorWithInternet.setUpLocators();
    HttpOverrides.global = null;
    WidgetsFlutterBinding.ensureInitialized();
  });
  testWidgets('SearchInputTest', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final mockClass = MyFunctionMock();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TestWidget(
            onChange: mockClass,
          ),
        ),
      ));
      //
      final textFormField = find.byKey(const Key('SearchKey'));
      expect(textFormField, findsOneWidget);
      await tester.enterText(textFormField, 'Rick');
      await tester.pump();
      await Future.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();
      expect(find.text('Rick'), findsOneWidget);
      verify(mockClass('Rick'));
    });
  });
}

final TextEditingController searchController = TextEditingController();

class TestWidget extends StatelessWidget {
  final Function(String) onChange;

  const TestWidget({
    super.key,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SearchInput(
            searchController: searchController,
            onChange: onChange,
          ),
        ],
      ),
    );
  }
}
