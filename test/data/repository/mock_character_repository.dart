import 'package:dartz/dartz.dart';
import 'package:jabu_test_bloc/data/models/failure_model.dart';
import 'package:jabu_test_bloc/data/repository/character_repository.dart';
import 'package:jabu_test_bloc/domain/models/character_model.dart';

class MockCharacterRepository implements CharacterRepository {
  @override
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    int page = 1,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    CharacterModel data = const CharacterModel(
      id: '1',
      name: 'Juan',
      status: CharacterStatus.alive,
      image: 'https://static.coinstats.app/coins/1650455588819.png',
      species: 'Human',
    );
    List<CharacterModel> rta = [];
    rta.add(data);
    rta.add(data);
    rta.add(data);
    rta.add(data);
    rta.add(data);

    return Right(rta);
  }

  @override
  Future<Either<FailureModel, CharacterModel>> getCharacterById(
      {required int id}) async {
    CharacterModel data = const CharacterModel(
      id: '1',
      name: 'Juan',
      status: CharacterStatus.alive,
      image: 'https://static.coinstats.app/coins/1650455588819.png',
      species: 'Human',
    );
    return Right(data);
  }
}
