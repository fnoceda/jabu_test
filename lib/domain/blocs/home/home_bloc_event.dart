// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc_bloc.dart';

abstract class HomeBlocEvent extends Equatable {
  const HomeBlocEvent();

  @override
  List<Object> get props => [];
}

class HomeBlocHttpFailEvent extends HomeBlocEvent {
  final String errorMessage;
  const HomeBlocHttpFailEvent({required this.errorMessage});
}

class HomeBlocHttpLoadingEvent extends HomeBlocEvent {
  const HomeBlocHttpLoadingEvent();
}

class HomeBlocHttpLoadingMoreEvent extends HomeBlocEvent {
  const HomeBlocHttpLoadingMoreEvent();
}

class HomeBlocHttpSuccessEvent extends HomeBlocEvent {
  final int page;
  final List<CharacterModel> characters;
  final List<CustomListTileModel> viewNewData;

  const HomeBlocHttpSuccessEvent({
    required this.characters,
    required this.viewNewData,
    required this.page,
  });
}

class HomeBlocChangeFilterEvent extends HomeBlocEvent {
  final String? filterString;
  final String? filterStringType;
  final String? filterStatus;

  const HomeBlocChangeFilterEvent({
    required this.filterString,
    required this.filterStringType,
    required this.filterStatus,
  });
}
