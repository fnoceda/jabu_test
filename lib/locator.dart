import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:jabu_test_bloc/presentation/widgets/cache_network_image_wrapper.dart';
import 'package:path_provider/path_provider.dart';

import 'data/repository/data_sources.dart.dart';
import 'data/services/character_local_service.dart';
import 'data/services/character_remote_service.dart';
import 'data/services/check_internet_service.dart';
import 'data/sources/local_data/character_local_data.dart';
import 'data/sources/local_data/collections/character_collection.dart';
import 'data/sources/remote_data/character_remote_data.dart';
import 'domain/repository/character_repository.dart';

class Locator {
  const Locator._();
  static final sl = GetIt.instance;

  static setUpLocators() async {
    final dir = await getApplicationSupportDirectory();
    final isar =
        await Isar.open([CharacterCollectionSchema], directory: dir.path);

    CheckInternetService checkInternetService = CheckInternetService();
    CharacterRemoteData characterRemoteData =
        CharacterRemoteData(characterRemoteService: CharacterRemoteService());
    CharacterLocalData characterLocalData = CharacterLocalData(
        characterLocalService: CharacterLocalService(isar: isar));

    CharacterRepository characterRepository = CharacterDatsources(
      checkInternetService: checkInternetService,
      characterRemoteData: characterRemoteData,
      characterLocalData: characterLocalData,
    );

    // sl.registerSingleton<CheckInternetService>(CheckInternetService());
    sl.registerSingleton<CharacterRepository>(characterRepository);

    sl.registerSingleton<CachedNetworkImageWrapper>(
        CachedNetworkImageWrapper());
  }
}
