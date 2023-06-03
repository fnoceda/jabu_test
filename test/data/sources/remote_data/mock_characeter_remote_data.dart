import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:jabu_test/data/models/failure_model.dart';
import 'package:jabu_test/data/sources/remote_data/character_remote_data.dart';
import 'package:jabu_test/domain/models/character_model.dart';
import 'package:mockito/mockito.dart';

class MockCharacterRemoteData extends Mock implements CharacterRemoteData {
  @override
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    required int page,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    try {
      filterStringType = filterStringType?.trim() ?? '';

      if (filterStringType != '' &&
          filterStringType != 'name' &&
          filterStringType != 'species') {
        return const Left(FailureModel(status: 500, message: 'Bad Filter'));
      }

      List<CharacterModel> rta = _getData();

      return Right(rta);
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      return const Left(
        FailureModel(status: 500, message: 'Fail retriving local data'),
      );
    }
  }

  List<CharacterModel> _getData() {
    List<CharacterModel> data = [];
    Map<String, dynamic> item;

    for (var i = 0; i < 20; i++) {
      item = {
        'id': i.toString(),
        'name': 'Name $i',
        'status': (i % 2 == 0) ? 'alive' : 'dead',
        'image': '',
        'species': 'Alien'
      };

      data.add(CharacterModel.fromMap(item));
    }
    return data;
  }
}
