import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jabu_test/app/router.dart';
import 'package:jabu_test/domain/blocs/detail/detail_bloc.dart';
import 'package:jabu_test/domain/repository/character_repository.dart';
import 'package:jabu_test/presentation/widgets/cache_network_image_wrapper.dart';
import 'package:jabu_test/utils/enums.dart';

import '../../../app/mock_locator.dart';

void main() {
  late DetailBloc bloc;

  WidgetsFlutterBinding.ensureInitialized();
  AppNavigator.configureRoutes();
  LocatorWithInternet.setUpLocators();
  HttpOverrides.global = null;

  setUp(() {
    bloc = DetailBloc(
      imageBuilder: LocatorWithInternet.sl.get<CachedNetworkImageWrapper>(),
      repo: LocatorWithInternet.sl.get<CharacterRepository>(),
    );
  });

  group('Detail Bloc Test', () {
    test('Init', () async {
      expect(bloc.state.character, null);
      expect(bloc.state.fetchStatus, FetchDataStatus.none);
    });
    test('getCharacter', () async {
      expect(bloc.state.character, null);
      expect(bloc.state.fetchStatus, FetchDataStatus.none);
      await bloc.getCharacter(id: '1');
      expectLater(bloc.state.fetchStatus, FetchDataStatus.fetching);
      await Future.delayed(const Duration(milliseconds: 100));
      expectLater(bloc.state.fetchStatus, FetchDataStatus.success);
    });
  });
}
