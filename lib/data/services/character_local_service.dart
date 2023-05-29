import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:jabu_test_bloc/data/models/failure_model.dart';
import 'package:jabu_test_bloc/domain/models/character_model.dart';

import '../../domain/repository/character_repository.dart';
import '../sources/local_data/collections/character_collection.dart';

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
    required int page,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    List<CharacterModel> rta = [];
    try {
      page = (page >= 1) ? page - 1 : 0;
      print(
          'CharacterLocalService.page => $page $filterStatus $filterStringType $filterString');
      // var allCollections;

      var totalCollections = await isar.characterCollections.where().findAll();
      print('totalCollections => ${totalCollections.length}');

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
            return q.statusEqualTo(filterStatus!.trim());
          })
          .optional(filterByName, (q) {
            print('filterByName => $filterString');
            return q.nameContains(
              filterString!.trim().toLowerCase(),
              caseSensitive: false,
            );
          })
          .optional(filterBySpecie, (q) {
            print('filterBySpecie => $filterString');

            return q.specieContains(
              filterString!.trim().toLowerCase(),
              caseSensitive: false,
            );
          })
          .offset(page * 20)
          .limit(20)
          .findAll();

      await Future.delayed(const Duration(milliseconds: 100));

      print('allCollections1.length=>${allCollections.length}');

      for (var e in allCollections) {
        // print('${e.id} ${e.name} => "${e.status}"');
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

  @override
  Future<Either<FailureModel, CharacterModel>> getCharacterById({
    required int id,
  }) async {
    try {
      var e = await isar.characterCollections.get(id);
      await Future.delayed(const Duration(milliseconds: 100));
      if (e != null) {
        var character = CharacterModel(
          id: e.id.toString(),
          name: e.name,
          status: mapStatusValues[e.status]!,
          image: e.image,
          species: e.specie,
        );
        return Right(character);
      }
      return const Left(
        FailureModel(status: 404, message: 'Character not found'),
      );
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
