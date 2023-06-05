import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jabu_test/app/router.dart';
import 'package:jabu_test/domain/blocs/home/home_bloc_bloc.dart';
import 'package:jabu_test/domain/repository/character_repository.dart';
import 'package:jabu_test/presentation/cubit/home_cubit_cubit.dart';
import 'package:jabu_test/presentation/widgets/cache_network_image_wrapper.dart';
import 'package:jabu_test/presentation/widgets/status_filter_widget.dart';
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

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => HomeBlocBloc(
                repo: LocatorWithInternet.sl.get<CharacterRepository>(),
                imageBuilder:
                    LocatorWithInternet.sl.get<CachedNetworkImageWrapper>(),
              ),
            ),
            BlocProvider(create: (_) => HomeCubitCubit()),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: TestWidget(
                onChange: mockClass,
              ),
            ),
          ),
        ),
      );
      //
      final allOption = find.text('All');
      final aliveOption = find.text('Alive');
      final deadOption = find.text('Dead');
      final segmentedButton = find.byKey(const Key('SegmentedButton.Key'));
      expect(allOption, findsOneWidget);
      expect(aliveOption, findsOneWidget);
      expect(deadOption, findsOneWidget);
      expect(segmentedButton, findsOneWidget);
      await tester.tap(aliveOption);
      await tester.pump();
      verify(mockClass('alive'));
      await tester.tap(deadOption);
      await tester.pump();
      verify(mockClass('dead'));
      await tester.tap(allOption);
      await tester.pump();
      verify(mockClass('all'));
    });
  });
}

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
          StatusFilterWidget(
            onChange: (String value) {
              onChange(value);
            },
          ),
        ],
      ),
    );
  }
}
