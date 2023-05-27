import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../utils/config.dart';
import '../models/failure_model.dart';
import '../models/success_model.dart';

GraphQLClient graphQLClient = GraphQLClient(
  cache: GraphQLCache(store: HiveStore()),
  link: HttpLink(AppConfig.baseUrl),
);

class CharacterRemoteService {
  List<dynamic> result = [];
  Future<Either<FailureModel, SuccessModel>> getCharacterList({
    int page = 1,
    String? filterName,
    String? filterStatus,
    String? filterSpecies,
  }) async {
    String filters = "";
    if (filterName != null && filterName.trim() != "") {
      filters += 'name: "$filterName"';
    }

    if (filterStatus != null &&
        filterStatus.trim() != "" &&
        filterStatus.trim() != "all") {
      filters += 'status: "$filterStatus"';
    }

    if (filterSpecies != null && filterSpecies.trim() != "") {
      filters += 'species: "$filterSpecies"';
    }

    print('CharacterRemoteService.filterStatus=> $filterStatus');
    // print('CharacterRemoteService.filterSpecies=> $filterSpecies');
    print('CharacterRemoteService.filterName=> $filterName');

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

    print(result.data);

    try {
      // if (kDebugMode) print(result.data?['characters']);

      return Right(
        SuccessModel(
          status: 200,
          message: 'OK',
          data: result.data?['characters']['results'],
        ),
      );
    } catch (e) {
      print(e);
      return const Left(
          FailureModel(status: 500, message: 'Fail Retriving data'));
    }
  }
}
