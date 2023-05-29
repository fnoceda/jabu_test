import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/models/character_model.dart';
import '../../../domain/repository/character_repository.dart';
import '../../models/failure_model.dart';
import '../../services/character_local_service.dart';

class CharacterLocalData implements ICharacterLocalRepository {
  final CharacterLocalService characterLocalService;

  CharacterLocalData({required this.characterLocalService});
  @override
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    required int page,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    try {
      // print('CharacterLocalData.page = $page');
      return await characterLocalService.getCharacterList(
        page: page,
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

  @override
  Future<Either<FailureModel, CharacterModel>> getCharacterById(
      {required int id}) async {
    return await characterLocalService.getCharacterById(id: id);
  }
}
