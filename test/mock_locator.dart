import 'package:get_it/get_it.dart';
import 'package:jabu_test_bloc/data/repository/character_repository.dart';

import 'data/repository/mock_character_repository.dart';

class MockGetIt {
  const MockGetIt._();
  static final sl = GetIt.instance;
  static setUpLocators() {
    sl.registerSingleton<CharacterRepository>(MockCharacterRepository());
  }
}
