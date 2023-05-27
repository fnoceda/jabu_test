import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:jabu_test_bloc/data/models/failure_model.dart';
import 'package:jabu_test_bloc/data/repository/character_repository.dart';
import 'package:jabu_test_bloc/domain/models/character_model.dart';

import '../data_source/local_data/collections/character_collection.dart';

class CharacterLocalService implements ICharacterLocalRepository {
  final Isar isar;
  CharacterLocalService({required this.isar});

  @override
  Future<void> save({required List<CharacterModel> data}) async {
    for (CharacterModel e in data) {
      final character = CharacterCollection()
        ..id = int.parse(e.id)
        ..name = e.name
        ..status = e.status.name
        ..image = e.image
        ..specie = e.species;
      await isar.writeTxn(() async {
        await isar.characterCollections.put(character);
      });
    }
  }

  @override
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    List<CharacterModel> rta = [];
    try {
      final allCollections = await isar.characterCollections.where().findAll();

      for (var e in allCollections) {
        rta.add(
          CharacterModel(
            id: e.id.toString(),
            name: e.name,
            status: mapStatusValues[e.status]!,
            image: e.image,
            species: e.specie,
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
}
