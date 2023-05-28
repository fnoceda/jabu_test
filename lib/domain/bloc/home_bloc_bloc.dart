import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jabu_test_bloc/data/repository/character_repository.dart';
import 'package:jabu_test_bloc/domain/models/character_model.dart';
import 'package:jabu_test_bloc/presentation/models/list_view_model.dart';
import '../../utils/enums.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final CharacterRepository repo;
  HomeBlocBloc({required this.repo}) : super(HomeBlocState.initial()) {
    on<HomeBlocEvent>((event, emit) {});
    on<HomeBlocHttpLoadingEvent>((event, emit) {
      // print( 'HomeBlocHttpLoadingEvent.state.filterStatus => ${state.filterStatus}');
      emit(state.copyWith(
        requestStatus: RequestStatus.loading,
        listViewData: [],
        characters: [],
      ));
      // print(  'HomeBlocHttpLoadingEvent.finish.filterStatus => ${state.filterStatus}');
    });

    on<HomeBlocHttpLoadingMoreEvent>((event, emit) {
      // print('HomeBlocHttpLoadingMoreEvent.finish.page => ${state.page}');

      // print('HomeBlocHttpLoadingMoreEvent.init');
      emit(state.copyWith(requestStatus: RequestStatus.more));
      // print('HomeBlocHttpLoadingMoreEvent.finish.page => ${state.page}');
      // print( 'HomeBlocHttpLoadingMoreEvent.finish.filterStatus => ${state.filterStatus}');
    });

    on<HomeBlocHttpFailEvent>((event, emit) {
      emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          errorMessage: event.errorMessage,
        ),
      );
    });

    on<HomeBlocHttpSuccessEvent>((event, emit) {
      print(
          'HomeBlocHttpSuccessEvent.state.filterStatus => ${state.filterStatus}');
      emit(
        state.copyWith(
            page: event.page,
            requestStatus: RequestStatus.success,
            errorMessage: '',
            characters: [...state.characters, ...event.characters],
            listViewData: [...state.listViewData, ...event.viewNewData]),
      );
      print(
          'HomeBlocHttpSuccessEvent.finish.filterStatus => ${state.filterStatus}');
    });

    on<HomeBlocChangeFilterEvent>((event, emit) {
      // print( 'HomeBlocChangeFilterEvent.event.filterStatus=>${event.filterStatus}');
      // print('ants=>$state');
      emit(state.copyWith(
        page: 1,
        filterString: event.filterString ?? state.filterString,
        filterStatus: event.filterStatus ?? state.filterStatus,
        filterStringType: event.filterStringType ?? state.filterStringType,
      ));
      print(
          'HomeBlocChangeFilterEvent.finish.filterStatus=>${state.filterStatus}');
      // print('dsps=>$state');
    });

    _init();
  }

  _init() {
    getNewData();
  }

  changeFilters({
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    // print( 'changeFilters.param.filterStatus=>$filterStatus filterName=> $filterString filterSpecies=> $filterStringType');
    // print( 'changeFilters.state.filterStatus=>${state.filterStatus} filterName=> ${state.filterString} filterSpecies=>${state.filterStringType}');
    // print('changeFilters.init');
    add(HomeBlocChangeFilterEvent(
      filterString: filterString,
      filterStatus: filterStatus,
      filterStringType: filterStringType,
    ));

    filterString = filterString ?? state.filterString;
    filterStatus = filterStatus ?? state.filterStatus;
    filterStringType = filterStringType ?? state.filterStringType;

    bool searchCond = filterString != null && filterStringType != null ||
        filterStatus != null;

    if (searchCond) {
      print('HomeBloc.searchData=> $searchCond');

      await getNewData(
        filterString: filterString ?? state.filterString,
        filterStatus: filterStatus ?? state.filterStatus,
        filterStringType: filterStringType ?? state.filterStringType,
      );
    } else {
      print('HomeBloc.searchCond=> $searchCond');
    }

    // print('changeFilters.state.filterName=> ${state.filterName}');
    // print('changeFilters.state.filterStatus=> ${state.filterStatus}');
    // print('changeFilters.state.filterSpecies=> ${state.filterSpecies}');
  }

  Future<void> getNewData({
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    add(const HomeBlocHttpLoadingEvent()); //kaka
    // print('getNewData.param.filterStatus=>${filterStatus}');
    await getData(
      page: 1,
      filterStatus: filterStatus,
      filterString: filterString,
      filterStringType: filterStringType,
    );
  }

  Future<List<ListViewModel>> getMoreData() async {
    add(const HomeBlocHttpLoadingMoreEvent());
    // print('getMoreData.filterStatus => ${state.filterStatus}');
    // print('getMoreData.page => ${state.page}');

    List<ListViewModel> rta = await getData(
      page: state.page + 1,
      filterStatus: state.filterStatus,
      filterString: state.filterString,
      filterStringType: state.filterStringType,
    );
    return rta;
  }

  Future<List<ListViewModel>> getData({
    required int page,
    String? filterStatus,
    String? filterString,
    String? filterStringType,
  }) async {
    List<ListViewModel> rta = [];

    var result = await repo.getCharacterList(
      page: page,
      filterStatus: filterStatus,
      filterString: filterString,
      filterStringType: filterStringType,
    );
    rta = result.fold((l) {
      add(HomeBlocHttpFailEvent(errorMessage: l.message));
      return [];
    }, (r) {
      List<ListViewModel> newViewData = r.map((e) {
        return ListViewModel(
          title: e.name,
          subTitle: e.species,
          status: e.status == CharacterStatus.alive ? "alive" : "dead",
          imageUrl: e.image,
        );
      }).toList();
      var lastPage = (r.length > 0) ? state.page + 1 : state.page;
      add(HomeBlocHttpSuccessEvent(
          characters: r, viewNewData: newViewData, page: lastPage));
      return newViewData;
    });
    return rta;
  }
}
