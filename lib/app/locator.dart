import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:isar/isar.dart';
import 'package:jabu_test/presentation/widgets/cache_network_image_wrapper.dart';
import 'package:jabu_test/utils/config.dart';
import 'package:path_provider/path_provider.dart';

import '../data/repository/data_sources.dart.dart';
import '../data/services/check_internet_service.dart';
import '../data/sources/local_data/character_local_data.dart';
import '../data/sources/local_data/collections/character_collection.dart';
import '../data/sources/remote_data/character_remote_data.dart';
import '../domain/repository/character_repository.dart';

class Locator {
  const Locator._(); // coverage:ignore-line
  static final sl = GetIt.instance;

  static setUpLocators() async {
    final dir = await getApplicationSupportDirectory();
    final isar =
        await Isar.open([CharacterCollectionSchema], directory: dir.path);
    CheckInternetService checkInternetService = CheckInternetService();

    // CharacterLocalData characterLocalData = CharacterLocalData(characterLocalService: CharacterLocalService(isar: isar));

    CharacterLocalData characterLocalData = CharacterLocalData(isar: isar);

    GraphQLClient graphQLClient = GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: HttpLink(AppConfig.baseUrl),
    );

    // CharacterRemoteData characterRemoteData = CharacterRemoteData( characterRemoteService: CharacterRemoteService(graphQLClient: graphQLClient));

    CharacterRemoteData characterRemoteData =
        CharacterRemoteData(graphQLClient: graphQLClient);

    CharacterRepository characterRepository = CharacterDatsources(
      checkInternetService: checkInternetService,
      characterRemoteData: characterRemoteData,
      characterLocalData: characterLocalData,
    );

    sl.registerSingleton<CharacterRepository>(characterRepository);

    sl.registerSingleton<CachedNetworkImageWrapper>(
        CachedNetworkImageWrapper());
  }
}
