import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jabu_test/presentation/widgets/custom_app_bar.dart';

void main() {
  testWidgets('App Bar', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(appBar: CustomAppBar(title: 'Test Title')),
    ));

    expect(find.text('Test Title'), findsOneWidget);
  });
}
