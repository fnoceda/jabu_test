import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:jabu_test/data/models/failure_model.dart';
import 'package:jabu_test/data/sources/remote_data/character_remote_data.dart';
import 'package:jabu_test/domain/models/character_model.dart';
import 'package:mockito/mockito.dart';

var result = {
  "data": {
    "characters": {
      "results": [
        {
          "id": "1",
          "name": "Rick Sanchez",
          "status": "Alive",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        },
        {
          "id": "2",
          "name": "Morty Smith",
          "status": "Alive",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
        },
        {
          "id": "3",
          "name": "Summer Smith",
          "status": "Alive",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/3.jpeg"
        },
        {
          "id": "4",
          "name": "Beth Smith",
          "status": "Alive",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/4.jpeg"
        },
        {
          "id": "5",
          "name": "Jerry Smith",
          "status": "Alive",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/5.jpeg"
        },
        {
          "id": "6",
          "name": "Abadango Cluster Princess",
          "status": "Alive",
          "species": "Alien",
          "image": "https://rickandmortyapi.com/api/character/avatar/6.jpeg"
        },
        {
          "id": "7",
          "name": "Abradolf Lincler",
          "status": "unknown",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/7.jpeg"
        },
        {
          "id": "8",
          "name": "Adjudicator Rick",
          "status": "Dead",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/8.jpeg"
        },
        {
          "id": "9",
          "name": "Agency Director",
          "status": "Dead",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/9.jpeg"
        },
        {
          "id": "10",
          "name": "Alan Rails",
          "status": "Dead",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/10.jpeg"
        },
        {
          "id": "11",
          "name": "Albert Einstein",
          "status": "Dead",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/11.jpeg"
        },
        {
          "id": "12",
          "name": "Alexander",
          "status": "Dead",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/12.jpeg"
        },
        {
          "id": "13",
          "name": "Alien Googah",
          "status": "unknown",
          "species": "Alien",
          "image": "https://rickandmortyapi.com/api/character/avatar/13.jpeg"
        },
        {
          "id": "14",
          "name": "Alien Morty",
          "status": "unknown",
          "species": "Alien",
          "image": "https://rickandmortyapi.com/api/character/avatar/14.jpeg"
        },
        {
          "id": "15",
          "name": "Alien Rick",
          "status": "unknown",
          "species": "Alien",
          "image": "https://rickandmortyapi.com/api/character/avatar/15.jpeg"
        },
        {
          "id": "16",
          "name": "Amish Cyborg",
          "status": "Dead",
          "species": "Alien",
          "image": "https://rickandmortyapi.com/api/character/avatar/16.jpeg"
        },
        {
          "id": "17",
          "name": "Annie",
          "status": "Alive",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/17.jpeg"
        },
        {
          "id": "18",
          "name": "Antenna Morty",
          "status": "Alive",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/18.jpeg"
        },
        {
          "id": "19",
          "name": "Antenna Rick",
          "status": "unknown",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/19.jpeg"
        },
        {
          "id": "20",
          "name": "Ants in my Eyes Johnson",
          "status": "unknown",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/20.jpeg"
        }
      ]
    }
  }
};

class MockCharacterRemoteData extends Mock implements CharacterRemoteData {
  @override
  Future<Either<FailureModel, List<CharacterModel>>> getCharacterList({
    required int page,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    print('entra en MockCharacterRemoteData');
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
}
