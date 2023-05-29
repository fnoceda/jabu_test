part of 'home_bloc_bloc.dart';

class HomeBlocState extends Equatable {
  final RequestStatus requestStatus;
  final List<CharacterModel> characters;
  final List<ListViewModel> listViewData;
  final String? errorMessage;

  final int page;
  final String? filterString;
  final String? filterStringType;
  final String? filterStatus;

  const HomeBlocState({
    this.requestStatus = RequestStatus.none,
    this.characters = const [],
    this.listViewData = const [],
    this.page = 0,
    this.errorMessage,
    this.filterString,
    this.filterStatus,
    this.filterStringType = 'name',
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
        filterStatus,
        filterString,
        filterStringType,
      ];

  HomeBlocState copyWith({
    RequestStatus? requestStatus,
    List<CharacterModel>? characters,
    List<ListViewModel>? listViewData,
    int? page,
    String? errorMessage,
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) {
    var l = HomeBlocState(
      requestStatus: requestStatus ?? this.requestStatus,
      characters: characters ?? this.characters,
      page: page ?? this.page,
      listViewData: listViewData ?? this.listViewData,
      errorMessage: errorMessage ?? this.errorMessage,
      filterStatus: filterStatus ?? this.filterStatus,
      filterString: filterString ?? this.filterString,
      filterStringType: filterStringType ?? this.filterStringType,
    );

    return l;
  }
}
