import 'package:get_it/get_it.dart';
import 'package:jabu_test_bloc/data/repository/character_repository.dart';
import 'package:jabu_test_bloc/presentation/widgets/cache_network_image_wrapper.dart';

import 'data/repository/mock_character_repository.dart';
import 'presentation/widgets/cache_network_image_wrapper.dart';

class MockGetIt {
  const MockGetIt._();
  static final sl = GetIt.instance;
  static setUpLocators() {
    sl.registerSingleton<CharacterRepository>(MockCharacterRepository());

    sl.registerSingleton<CachedNetworkImageWrapper>(
        MockCachedNetworkImageWrapper());
  }
}
