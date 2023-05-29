import 'package:dartz/dartz.dart';

import '../../data/models/failure_model.dart';
import '../models/character_model.dart';

abstract class ICharacterRemoteRepository {
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    required int page,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  });
}

abstract class ICharacterLocalRepository {
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    required int page,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  });
  Future<void> save({required List<CharacterModel> data});
  Future<Either<FailureModel, CharacterModel>> getCharacterById({
    required int id,
  });
}

abstract class CharacterRepository {
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    required int page,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  });
  Future<Either<FailureModel, CharacterModel>> getCharacterById({
    required String id,
  });
}
