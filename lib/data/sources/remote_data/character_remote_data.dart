// coverage:ignore-file

import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../domain/models/character_model.dart';
import '../../../domain/repository/character_repository.dart';
import '../../models/failure_model.dart';

class CharacterRemoteData implements ICharacterRemoteRepository {
  final GraphQLClient graphQLClient;

  CharacterRemoteData({required this.graphQLClient});

  @override
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    required int page,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    try {
      List<CharacterModel> rta = [];

      String filters = "";

      if (filterString != null && filterString.trim() != '') {
        if (filterStringType != null && filterStringType.trim() == "species") {
          filters += 'species: "$filterString"';
        } else {
          if (filterStringType != null && filterStringType.trim() == "name") {
            filters += 'name: "$filterString"';
          }
        }
      }

      if (filterStatus != null &&
          filterStatus.trim() != '' &&
          filterStatus.trim() != "all") {
        filters += 'status: "$filterStatus"';
      }

      // print('CharacterRemoteService.filterStatus=> $filterStatus');
      // print('CharacterRemoteService.filterSpecies=> $filterSpecies');
      // print('CharacterRemoteService.filterName=> $filterString');

      String query = """
                              query {
                                characters( page:$page filter: { $filters }) { 
                                  results {
                                    id
                                    name
                                    species
                                    status
                                    image
                                  }
                                }
                              }
                              """;

      // print(query);

      QueryResult<dynamic> result = await graphQLClient.query(
        QueryOptions(
          document: gql(query),
          fetchPolicy: FetchPolicy.noCache,
        ),
      );
      // result.data?['characters']['results']
      // print(result.data);

      rta.addAll((result.data?['characters']['results'] as List)
          .map((e) => CharacterModel.fromMap(e))
          .toList());
      return Right(rta);
    } catch (e) {
      // print(e);
      return const Left(
          FailureModel(status: 500, message: 'Fail Retriving data'));
    }
  }
}


/*
class CharacterRemoteData implements ICharacterRemoteRepository {
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
      print('entra en CharacterRemoteData ');
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
*/