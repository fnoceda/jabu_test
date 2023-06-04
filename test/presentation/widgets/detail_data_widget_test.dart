import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jabu_test/presentation/widgets/detail_data_widget.dart';
import 'package:uikit/models/custom_list_tile_model.dart';

final customListTileModel = CustomListTileModel(
  id: '1',
  title: 'Title 1',
  status: 'status',
  subTitle: 'subTitle',
  image: Container(),
);

void main() {
  testWidgets('DetailDataWidget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DetailDataWidget(
          model: customListTileModel,
        ),
      ),
    ));
    await tester.pumpAndSettle();
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.text('Name: Title 1'), findsOneWidget);
  });
}
