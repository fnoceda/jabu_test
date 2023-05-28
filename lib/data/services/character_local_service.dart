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
        ..name = e.name.trim()
        ..status = e.status.name.trim()
        ..image = e.image.trim()
        ..specie = e.species.trim();
      await isar.writeTxn(() async {
        await isar.characterCollections.put(character);
      });
    }
  }

  @override
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    int page = 1,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    List<CharacterModel> rta = [];
    try {
      print('page => $page $filterStatus $filterStringType $filterString');
      // var allCollections;

      bool filterByStatus = filterStatus != null &&
          filterStatus.trim() != '' &&
          filterStatus.trim() != 'all';

      bool filterByName = filterStringType == 'name' &&
          filterString != null &&
          filterString.trim() != '';

      bool filterBySpecie = filterStringType == 'species' &&
          filterString != null &&
          filterString.trim() != '';

      var allCollections = await isar.characterCollections
          .filter()
          .optional(filterByStatus, (q) {
        print("'$filterStatus'");
        // alive alive
        return q.statusContains(filterStatus!.trim());
      }).optional(filterByName, (q) {
        print('filterByName => $filterString');
        return q.nameContains(filterString!.trim());
      }).optional(filterBySpecie, (q) {
        print('filterBySpecie => $filterString');

        return q.specieContains(filterString!.trim());
      })
          // .offset(page * 20)
          // .limit(20)
          .findAll();

      print('allCollections1.length=>${allCollections.length}');

      // if (filterStatus != null &&
      //     filterStatus.trim() != '' &&
      //     filterStatus.trim() != 'all') {
      //   allCollections = await isar.characterCollections
      //       .where()
      //       .statusEqualTo("alive")
      //       .offset(page * 20)
      //       .limit(20)
      //       .findAll();
      // }
      // print('allCollections2.length=>${allCollections.length}');

      for (var e in allCollections) {
        print('${e.id} ${e.name} => "${e.status}"');
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
