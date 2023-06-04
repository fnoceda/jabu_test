import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jabu_test/app/router.dart';
import 'package:jabu_test/domain/blocs/home/home_bloc_bloc.dart';
import 'package:jabu_test/domain/repository/character_repository.dart';
import 'package:jabu_test/presentation/widgets/cache_network_image_wrapper.dart';
import 'package:jabu_test/presentation/widgets/list_builder.dart';
import 'package:uikit/models/custom_list_tile_model.dart';
import 'package:uikit/widgets/custom_list_view_widget.dart';

import '../../app/mock_locator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late HomeBlocBloc bloc;
  setUpAll(() {
    AppNavigator.configureRoutes();
    LocatorWithInternet.setUpLocators();
    HttpOverrides.global = null;
    WidgetsFlutterBinding.ensureInitialized();
  });
  testWidgets('ListBuilder', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(BlocProvider(
        create: (_) => HomeBlocBloc(
          repo: LocatorWithInternet.sl.get<CharacterRepository>(),
          imageBuilder: LocatorWithInternet.sl.get<CachedNetworkImageWrapper>(),
        ),
        child: MaterialApp(
          home: Scaffold(
            body: BlocBuilder<HomeBlocBloc, HomeBlocState>(
              builder: (context, state) {
                bloc = context.read<HomeBlocBloc>();
                return TestWidget(
                  getMoreData: context.read<HomeBlocBloc>().getMoreData,
                );
              },
            ),
          ),
        ),
      ));
      //
      expect(
          find.byType(BlocBuilder<HomeBlocBloc, HomeBlocState>), findsWidgets);
      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoActivityIndicator), findsNothing);
      expect(find.byType(CustomListView), findsOneWidget);
      expect(bloc.state.characters.length, 20);
      // scroll and load more
      await tester.drag(find.byType(ListView), const Offset(0.0, -10000));
      await tester.pumpAndSettle();
      final lastItem = find.text('Name 19');
      expect(lastItem, findsWidgets);
      await tester.pumpAndSettle();
      expect(bloc.state.characters.length, 40);
    });
  });
}

class TestWidget extends StatelessWidget {
  final Future<List<CustomListTileModel>> Function()? getMoreData;
  const TestWidget({
    super.key,
    required this.getMoreData,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ListBuilder(loadMoreData: getMoreData),
        ],
      ),
    );
  }
}
