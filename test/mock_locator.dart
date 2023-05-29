import 'package:get_it/get_it.dart';
import 'package:jabu_test_bloc/data/repository/data_sources.dart.dart';
import 'package:jabu_test_bloc/data/sources/local_data/character_local_data.dart';
import 'package:jabu_test_bloc/data/sources/remote_data/character_remote_data.dart';
import 'package:jabu_test_bloc/domain/repository/character_repository.dart';
import 'package:jabu_test_bloc/presentation/widgets/cache_network_image_wrapper.dart';

import 'data/services/characeter_remote_service.dart';
import 'data/services/character_local_service.dart';
import 'data/services/mock_check_internet_services.dart';
import 'presentation/widgets/cache_network_image_wrapper.dart';

class MockGetItWithInternet {
  const MockGetItWithInternet._();
  static final sl = GetIt.instance;
  static setUpLocators() async {
    CharacterRemoteData characterRemoteData = CharacterRemoteData(
        characterRemoteService: MockCharacterRemoteService());

    CharacterLocalData characterLocalData =
        CharacterLocalData(characterLocalService: MockCharacterLocalService());

    CharacterRepository mockCharacterRepository = CharacterDatsources(
      checkInternetService: MockCheckInternetServiceTrue(),
      characterRemoteData: characterRemoteData,
      characterLocalData: characterLocalData,
    );

    sl.registerSingleton<CharacterRepository>(mockCharacterRepository);

    sl.registerSingleton<CachedNetworkImageWrapper>(
        MockCachedNetworkImageWrapper());
  }
}
