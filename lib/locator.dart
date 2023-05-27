import 'package:get_it/get_it.dart';
import 'package:jabu_test_bloc/data/data_source/local_data/character_local_data.dart';

import 'data/data_source/remote_data/character_remote_data.dart';
import 'data/repository/character_repository.dart';
import 'data/services/character_local_service.dart';
import 'data/services/character_remote_service.dart';
import 'data/services/check_internet_service.dart';

class Locator {
  const Locator._();
  static final sl = GetIt.instance;

  static setUpLocators() {
    CheckInternetService checkInternetService = CheckInternetService();
    CharacterRemoteData characterRemoteData =
        CharacterRemoteData(characterRemoteService: CharacterRemoteService());
    CharacterLocalData characterLocalData =
        CharacterLocalData(characterLocalService: CharacterLocalService());

    CharacterRepository characterRepository = CharacterDatsources(
      checkInternetService: checkInternetService,
      characterRemoteData: characterRemoteData,
      characterLocalData: characterLocalData,
    );

    // sl.registerSingleton<CheckInternetService>(CheckInternetService());
    sl.registerSingleton<CharacterRepository>(characterRepository);
  }
}
