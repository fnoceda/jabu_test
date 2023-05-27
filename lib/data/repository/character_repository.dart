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
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) {
    throw UnimplementedError();
  }
}

class CharacterDatsources implements CharacterRepository {
  final CheckInternetService checkInternetService;
  final CharacterRemoteData characterRemoteData;
  final CharacterLocalData characterLocalData;

  CharacterDatsources({
    required this.characterRemoteData,
    required this.checkInternetService,
    required this.characterLocalData,
  });

  @override
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    int page = 1,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    bool hasInternet = await checkInternetService.checkInternet();
    if (hasInternet) {
      var data = await characterRemoteData.getCharacterList(
        page: page,
        filterString: filterString,
        filterStatus: filterStatus,
        filterStringType: filterStringType,
      );

      // aqui guardar

      return data;
    }
    return const Left(FailureModel(status: 500, message: 'Unimplemented'));
  }
}
