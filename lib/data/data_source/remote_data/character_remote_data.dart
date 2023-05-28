import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/models/character_model.dart';
import '../../models/failure_model.dart';
import '../../repository/character_repository.dart';
import '../../services/character_remote_service.dart';

class CharacterRemoteData implements CharacterRepository {
  final CharacterRemoteService characterRemoteService;

  CharacterRemoteData({required this.characterRemoteService});

  @override
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    required int page,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    Either<FailureModel, List<CharacterModel>> rta;
    try {
      var result = await characterRemoteService.getCharacterList(
        page: page,
        filterString: filterString,
        filterStatus: filterStatus,
        filterStringType: filterStringType,
      );

      rta = result.fold((l) => Left(l), (r) {
        List<CharacterModel> list = [];
        list.addAll(
            (r.data as List).map((e) => CharacterModel.fromMap(e)).toList());
        return Right(list);
      });
    } catch (e, s) {
      if (kDebugMode) print(e);
      if (kDebugMode) print(s);
      rta = const Left(FailureModel(status: 500, message: 'Unknow Error'));
    }
    return rta;
  }
}
