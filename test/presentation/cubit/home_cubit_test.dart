import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jabu_test/app/router.dart';
import 'package:jabu_test/presentation/cubit/home_cubit_cubit.dart';
import 'package:jabu_test/utils/enums.dart';

import '../../app/mock_locator.dart';

void main() {
  late HomeCubitCubit bloc;

  WidgetsFlutterBinding.ensureInitialized();
  AppNavigator.configureRoutes();
  LocatorWithInternet.setUpLocators();
  HttpOverrides.global = null;

  setUp(() {
    bloc = HomeCubitCubit();
  });

  group('HomeCubit Test > ', () {
    test('Init', () async {
      expect(bloc.state.dataStatusFilter, DataFilter.all);
      expect(bloc.state.searchType, SearchType.name);
    });

    test('changeDataStatusFilter.alive', () async {
      expect(bloc.state.dataStatusFilter, DataFilter.all);
      bloc.changeDataStatusFilter(DataFilter.alive);
      expect(bloc.state.dataStatusFilter, DataFilter.alive);
    });

    test('changeDataStatusFilter.dead', () async {
      expect(bloc.state.dataStatusFilter, DataFilter.all);
      bloc.changeDataStatusFilter(DataFilter.dead);
      expect(bloc.state.dataStatusFilter, DataFilter.dead);
    });

    test('changeSearchType', () async {
      expect(bloc.state.searchType, SearchType.name);
      bloc.changeSearchType(SearchType.species);
      expect(bloc.state.searchType, SearchType.species);
    });

    test('HomeCubitState.toString', () async {
      final text = bloc.state.toString();
      expect(text.contains('HomeCubitState'), true);
    });
  });
}
