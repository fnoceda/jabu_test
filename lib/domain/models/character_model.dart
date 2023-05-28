import 'dart:convert';

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
  @override
  List<Object> get props {
    return [
      id,
      name,
      status,
      image,
      species,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status.name,
      'image': image,
      'species': species,
    };
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

  String toJson() => json.encode(toMap());

  factory CharacterModel.fromJson(String source) =>
      CharacterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  String toString() {
    return "CharacterModel(id: $id, name: $name, status: $status, species: $species, image: $image  )";
  }
}
