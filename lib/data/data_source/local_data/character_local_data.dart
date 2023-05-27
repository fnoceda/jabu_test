import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/models/character_model.dart';
import '../../models/failure_model.dart';
import '../../repository/character_repository.dart';
import '../../services/character_local_service.dart';

class CharacterLocalData implements ICharacterLocalRepository {
  final CharacterLocalService characterLocalService;

  CharacterLocalData({required this.characterLocalService});
  @override
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    try {
      return await characterLocalService.getCharacterList(
        filterString: filterString,
        filterStatus: filterStatus,
        filterStringType: filterStringType,
      );
    } catch (e, s) {
      if (kDebugMode) print(e);
      if (kDebugMode) print(s);
      return const Left(FailureModel(status: 500, message: 'No timplemented'));
    }
  }

  @override
  Future<void> save({required List<CharacterModel> data}) async {
    await characterLocalService.save(data: data);
  }
}
