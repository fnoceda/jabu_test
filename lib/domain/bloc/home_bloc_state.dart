// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc_bloc.dart';

class HomeBlocState extends Equatable {
  final RequestStatus requestStatus;
  final List<CharacterModel> characters;
  final List<ListViewModel> listViewData;
  final String? errorMessage;

  final int page;
  final String? filterString;
  final String? filterStatus;
  final String? filterSpecies;

  const HomeBlocState({
    this.requestStatus = RequestStatus.none,
    this.characters = const [],
    this.listViewData = const [],
    this.page = 0,
    this.errorMessage,
    this.filterString,
    this.filterStatus,
    this.filterSpecies,
  });

  factory HomeBlocState.initial() {
    return const HomeBlocState(
      requestStatus: RequestStatus.none,
      characters: [],
      listViewData: [],
      page: 0,
    );
  }

  @override
  List<Object?> get props => [
        requestStatus,
        characters,
        listViewData,
        page,
        errorMessage,
        filterString,
        filterStatus,
        filterSpecies,
      ];

  HomeBlocState copyWith({
    RequestStatus? requestStatus,
    List<CharacterModel>? characters,
    List<ListViewModel>? listViewData,
    int? page,
    String? errorMessage,
    String? filterName,
    String? filterStatus,
    String? filterSpecies,
  }) {
    print('copyWith.filterStatus.ants=>$filterStatus');

    var l = HomeBlocState(
      requestStatus: requestStatus ?? this.requestStatus,
      characters: characters ?? this.characters,
      page: page ?? this.page,
      listViewData: listViewData ?? this.listViewData,
      errorMessage: errorMessage ?? this.errorMessage,
      filterString: filterName ?? this.filterString,
      filterStatus: filterStatus ?? this.filterStatus,
      filterSpecies: filterSpecies ?? this.filterSpecies,
    );
    print('copyWith.filterStatus.dsps=>${l.filterStatus}');

    return l;
  }
}
