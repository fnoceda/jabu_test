import 'package:isar/isar.dart';
part 'character_collection.g.dart';

@Collection()
class CharacterCollection {
  @Index(replace: true)
  Id? id;

  @Index()
  late String name;

  @Index()
  late String status;

  late String image;

  @Index()
  late String specie;
}
