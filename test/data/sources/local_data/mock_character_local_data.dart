import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:jabu_test_bloc/data/models/failure_model.dart';
import 'package:jabu_test_bloc/data/sources/local_data/character_local_data.dart';
import 'package:jabu_test_bloc/domain/models/character_model.dart';
import 'package:mockito/mockito.dart';

class MockCharacterLocalData extends Mock implements CharacterLocalData {
  @override
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList(
      {required int page,
      String? filterString,
      String? filterStatus,
      String? filterStringType}) async {
    try {
      List<CharacterModel> rta = [];

      for (var i = 0; i < 20; i++) {
        rta.add(
          CharacterModel(
            id: '$i',
            name: 'Rick Alien',
            status: (i % 2 == 0) ? CharacterStatus.alive : CharacterStatus.dead,
            image: '',
            species: 'Alien',
          ),
        );
      }
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

  @override
  Future<Either<FailureModel, CharacterModel>> getCharacterById(
      {required int id}) async {
    try {
      var character = const CharacterModel(
        id: '1',
        name: 'Rick Alien',
        status: CharacterStatus.alive,
        image: '',
        species: 'Alien',
      );
      return Right(character);
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

  @override
  Future<void> save({required List<CharacterModel> data}) async {
    // for (CharacterModel e in data) {
    //   final character = CharacterCollection()
    //     ..id = int.parse(e.id)
    //     ..name = e.name.trim()
    //     ..status = e.status.name.trim()
    //     ..image = e.image.trim()
    //     ..specie = e.species.trim();
    //   await isar.writeTxn(() async {
    //     await isar.characterCollections.put(character);
    //   });
    // }
  }
}
