import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:jabu_test_bloc/data/data_source/local_data/character_local_data.dart';

import '../../domain/models/character_model.dart';
import '../data_source/remote_data/character_remote_data.dart';
import '../models/failure_model.dart';
import '../services/check_internet_service.dart';

abstract class ICharacterRemoteRepository {
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList();
}

abstract class ICharacterLocalRepository {
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    required int page,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  });
  Future<void> save({required List<CharacterModel> data});
}

abstract class CharacterRepository {
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    required int page,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  });
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
    required int page,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    try {
      print('CharacterDatsources.page=> $page');
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
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      return const Left(FailureModel(status: 500, message: 'Unimplemented'));
    }
  }
}
