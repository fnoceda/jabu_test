part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class DetailFechtFailEvent extends DetailEvent {
  final String errorMessage;
  const DetailFechtFailEvent({required this.errorMessage});
}

class DetailFechthingEvent extends DetailEvent {
  const DetailFechthingEvent();
}

class DetailFechthSuccessEvent extends DetailEvent {
  final CharacterModel character;
  final CustomListTileModel viewNewData;

  const DetailFechthSuccessEvent({
    required this.character,
    required this.viewNewData,
  });
}
