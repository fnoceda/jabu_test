import 'package:get_it/get_it.dart';
import 'package:jabu_test/app/locator.dart';
import 'package:jabu_test/data/repository/data_sources.dart.dart';
import 'package:jabu_test/data/sources/local_data/character_local_data.dart';
import 'package:jabu_test/data/sources/remote_data/character_remote_data.dart';
import 'package:jabu_test/domain/repository/character_repository.dart';
import 'package:jabu_test/presentation/widgets/cache_network_image_wrapper.dart';
import 'package:mockito/mockito.dart';

import '../data/sources/remote_data/mock_characeter_remote_data.dart';
import '../data/sources/local_data/mock_character_local_data.dart';
import '../data/services/mock_check_internet_services.dart';
import '../presentation/widgets/mock_cache_network_image_wrapper.dart';

class LocatorWithInternet extends Mock implements Locator {
  LocatorWithInternet._();
  static final sl = GetIt.instance;
  static setUpLocators() async {
    CharacterRemoteData characterRemoteData = MockCharacterRemoteData();
    CharacterLocalData characterLocalData = MockCharacterLocalData();

    CharacterRepository characterRepository = CharacterDatsources(
      checkInternetService: MockCheckInternetServiceTrue(),
      characterRemoteData: characterRemoteData,
      characterLocalData: characterLocalData,
    );

    sl.registerSingleton<CharacterRepository>(characterRepository);

    sl.registerSingleton<CachedNetworkImageWrapper>(
        MockCachedNetworkImageWrapper());
  }
}

class LocatorWithOutInternet extends Mock implements Locator {
  LocatorWithOutInternet._();
  static final sl = GetIt.instance;
  static setUpLocators() async {
    CharacterRemoteData characterRemoteData = MockCharacterRemoteData();
    CharacterLocalData characterLocalData = MockCharacterLocalData();

    CharacterRepository characterRepository = CharacterDatsources(
      checkInternetService: MockCheckInternetServiceFalse(),
      characterRemoteData: characterRemoteData,
      characterLocalData: characterLocalData,
    );

    sl.registerSingleton<CharacterRepository>(characterRepository);

    sl.registerSingleton<CachedNetworkImageWrapper>(
        MockCachedNetworkImageWrapper());
  }
}
