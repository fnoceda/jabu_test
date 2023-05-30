import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uikit/uikit.dart';

Future<List<CustomListTileModel>> getMoreData(BuildContext context) async {
  print('getMoreData.called!');
  await Future.delayed(const Duration(milliseconds: 1000));
  List<CustomListTileModel> result = [];

  for (var i = 0; i < 20; i++) {
    result.add(
      CustomListTileModel(
        id: '$i',
        title: 'title $i',
        status: 'status',
        subTitle: 'subTitle',
        image: Container(),
      ),
    );
  }
  print('getMoreData.finish!');

  return result;
}

main() {
  setUp(() {});

  group('UIKit Widget Test Group', () {
    testWidgets('UIKit Widget Test 1', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          const MaterialApp(
              home: TestWidget(
            loadMoreData: getMoreData,
          )),
        );

        final customListView = find.byType(CustomListView);
        expect(customListView, findsOneWidget);
        final customListTileItem = find.byType(CustomListTileItem);
        expect(customListTileItem, findsWidgets);
        final firstItem = find.text('title 0');
        expect(firstItem, findsWidgets);
        await tester.drag(find.byType(ListView), const Offset(0.0, -1200));
        await tester.pumpAndSettle();
        final lastItem = find.text('title 19');
        expect(lastItem, findsWidgets);
        await tester.pump(const Duration(milliseconds: 500));
      });
    });
  });
}

class TestWidget extends StatelessWidget {
  final Future<List<CustomListTileModel>> Function(BuildContext)? loadMoreData;

  const TestWidget({super.key, this.loadMoreData});

  @override
  Widget build(BuildContext context) {
    List<CustomListTileModel> data = [];

    for (var i = 0; i < 20; i++) {
      data.add(
        CustomListTileModel(
          id: '$i',
          title: 'title $i',
          status: 'status',
          subTitle: 'subTitle',
          image: Container(),
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: Scaffold(
        body: CustomListView(
          initialData: data,
          loadMoreData: loadMoreData,
          onItemTap: (String id) {
            print('id=>$id');
          },
        ),
      ),
    );
  }
}
