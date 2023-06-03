import 'package:equatable/equatable.dart';

enum CharacterStatus { alive, dead, otro }

Map<String, CharacterStatus> mapStatusValues = {
  "alive": CharacterStatus.alive,
  "dead": CharacterStatus.dead,
};

class CharacterModel extends Equatable {
  final String id;
  final String name;
  final CharacterStatus status;
  final String image;
  final String species;
  const CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.image,
    required this.species,
  });
  @override // coverage:ignore-line
  List<Object> get props {
    return [id, name, status, image, species];
  }

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'] ?? '',
      name: map['name'] ?? 'NO NAME',
      status: mapStatusValues[map['status'].toString().toLowerCase()] ??
          CharacterStatus.dead,
      image: map['image'] ?? '',
      species: map['species'] ?? '',
    );
  }

  @override // coverage:ignore-line
  bool get stringify => true;

  @override // coverage:ignore-line
  String toString() {
    return "CharacterModel(id: $id, name: $name, status: $status, species: $species, image: $image  )";
  }
}
