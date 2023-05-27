import 'package:dartz/dartz.dart';
import 'package:jabu_test_bloc/data/data_source/local_data/character_local_data.dart';

import '../../domain/models/character_model.dart';
import '../data_source/remote_data/character_remote_data.dart';
import '../models/failure_model.dart';
import '../services/check_internet_service.dart';

abstract class ICharacterRepository {
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList();
}

class CharacterRepository implements ICharacterRepository {
  @override
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    int page = 1,
    String? filterName,
    String? filterStatus,
    String? filterSpecies,
  }) {
    throw UnimplementedError();
  }
}

class CharacterDatsources implements CharacterRepository {
  final CharacterRemoteData characterRemoteData;
  final CheckInternetService checkInternetService;
  final CharacterLocalData characterLocalData;

  CharacterDatsources({
    required this.characterRemoteData,
    required this.checkInternetService,
    required this.characterLocalData,
  });

  @override
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    int page = 1,
    String? filterName,
    String? filterStatus,
    String? filterSpecies,
  }) async {
    bool hasInternet = await checkInternetService.checkInternet();
    if (hasInternet) {
      return await characterRemoteData.getCharacterList(
        page: page,
        filterName: filterName,
        filterStatus: filterStatus,
        filterSpecies: filterSpecies,
      );
    }
    return const Left(FailureModel(status: 500, message: 'Unimplemented'));
  }
}

// class CharacterRepository implements ICharacterRepository {
//   final CheckInternetService checkInternetService;
//   final CharacterRemoteService characterRemoteService;
//   final CharacterLocalData characterLocalService;

//   CharacterRepository({
//     required this.checkInternetService,
//     required this.characterRemoteService,
//     required this.characterLocalService,
//   });
//   @override
//   Future<Either<FailureModel, List<CharacterModel>>> getCharacterList() async {
//     final bool checkInternet = await checkInternetService.checkInternet();
//     CharacterRepository repo =
//         (checkInternet) ? characterRemoteService : characterLocalService;

//     return await repo.getCharacterList();
//   }
// }
