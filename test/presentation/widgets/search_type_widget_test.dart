import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jabu_test/app/router.dart';
import 'package:jabu_test/domain/blocs/home/home_bloc_bloc.dart';
import 'package:jabu_test/domain/repository/character_repository.dart';
import 'package:jabu_test/presentation/cubit/home_cubit_cubit.dart';
import 'package:jabu_test/presentation/widgets/cache_network_image_wrapper.dart';
import 'package:jabu_test/presentation/widgets/search_type_widget.dart';
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
      expect(find.text('Search By:   Name'), findsOneWidget);
      final speciesOption = find.byKey(const Key('SearchType.species'));
      final nameOption = find.byKey(const Key('SearchType.name'));
      expect(speciesOption, findsOneWidget);
      expect(nameOption, findsOneWidget);
      await tester.tap(speciesOption);
      await tester.pump();
      verify(mockClass('species'));
      await tester.tap(nameOption);
      await tester.pump();
      verify(mockClass('name'));
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
          SearchTypeWidget(onChange: onChange),
        ],
      ),
    );
  }
}
