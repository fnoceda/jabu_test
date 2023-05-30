import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jabu_test/app/router.dart';
import 'package:jabu_test/domain/blocs/home/home_bloc_bloc.dart';
import 'package:jabu_test/domain/repository/character_repository.dart';
import 'package:jabu_test/presentation/widgets/cache_network_image_wrapper.dart';
import 'package:jabu_test/utils/enums.dart';

import '../../../app/mock_locator.dart';

void main() {
  late HomeBlocBloc bloc;

  WidgetsFlutterBinding.ensureInitialized();
  AppNavigator.configureRoutes();
  LocatorWithInternet.setUpLocators();
  HttpOverrides.global = null;

  setUp(() {
    bloc = HomeBlocBloc(
      imageBuilder: LocatorWithInternet.sl.get<CachedNetworkImageWrapper>(),
      repo: LocatorWithInternet.sl.get<CharacterRepository>(),
    );
  });

  group('Home Bloc Test', () {
    test('Init', () async {
      expect(bloc.state.requestStatus, RequestStatus.loading);
      await Future.delayed(const Duration(milliseconds: 100));
      expectLater(bloc.state.requestStatus, RequestStatus.success);
      expectLater(bloc.state.characters.length, 20);
    });

    test('GetMoreData', () async {
      expect(bloc.state.requestStatus, RequestStatus.loading);
      await bloc.getMoreData();
      await Future.delayed(const Duration(milliseconds: 100));
      expectLater(bloc.state.requestStatus, RequestStatus.success);
      expectLater(bloc.state.characters.length, 40);
    });

    test('GetNewData', () async {
      expect(bloc.state.requestStatus, RequestStatus.loading);
      await bloc.getNewData();
      await Future.delayed(const Duration(milliseconds: 100));
      expectLater(bloc.state.requestStatus, RequestStatus.success);
      expectLater(bloc.state.characters.length, 20);
    });
  });
}
