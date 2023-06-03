import 'package:dartz/dartz.dart';

import '../../domain/models/character_model.dart';
import '../../domain/repository/character_repository.dart';
import '../sources/local_data/character_local_data.dart';
import '../sources/remote_data/character_remote_data.dart';
import '../models/failure_model.dart';
import '../services/check_internet_service.dart';

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
    required int page,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    try {
      bool hasInternet = await checkInternetService.checkInternet();
      Either<FailureModel, List<CharacterModel>> result;
      if (hasInternet) {
        result = await characterRemoteData.getCharacterList(
          page: page,
          filterString: filterString,
          filterStatus: filterStatus,
          filterStringType: filterStringType,
        );

        // aqui guardar
        result.fold((l) => null, (r) {
          characterLocalData.save(data: r);
        });
      } else {
        result = await characterLocalData.getCharacterList(
          page: page,
          filterString: filterString,
          filterStatus: filterStatus,
          filterStringType: filterStringType,
        );
      }
      return result;
    } catch (e) {
      return const Left(FailureModel(status: 500, message: 'Unknow Error'));
    }
  }

  @override
  Future<Either<FailureModel, CharacterModel>> getCharacterById(
      {required String id}) async {
    return characterLocalData.getCharacterById(id: int.parse(id));
  }
}
