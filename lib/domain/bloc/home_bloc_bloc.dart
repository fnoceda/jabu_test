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
      print(
          'HomeBlocHttpLoadingEvent.state.filterStatus => ${state.filterStatus}');
      emit(state.copyWith(
        requestStatus: RequestStatus.loading,
        listViewData: [],
        characters: [],
      ));
      print(
          'HomeBlocHttpLoadingEvent.finish.filterStatus => ${state.filterStatus}');
    });

    on<HomeBlocHttpLoadingMoreEvent>((event, emit) {
      print('HomeBlocHttpLoadingMoreEvent.init');
      emit(state.copyWith(
        requestStatus: RequestStatus.more,
        page: state.page + 1,
      ));
      print('HomeBlocHttpLoadingMoreEvent.finish.page => ${state.page}');
      print(
          'HomeBlocHttpLoadingMoreEvent.finish.filterStatus => ${state.filterStatus}');
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
            requestStatus: RequestStatus.success,
            errorMessage: '',
            characters: [...state.characters, ...event.characters],
            listViewData: [...state.listViewData, ...event.viewNewData]),
      );
      print(
          'HomeBlocHttpSuccessEvent.finish.filterStatus => ${state.filterStatus}');
    });

    on<HomeBlocChangeFilterEvent>((event, emit) {
      print(
          'HomeBlocChangeFilterEvent.event.filterStatus=>${event.filterStatus}');
      // print('ants=>$state');
      emit(state.copyWith(
        page: 1,
        filterName: event.filterName ?? state.filterString,
        filterStatus: event.filterStatus ?? state.filterStatus,
        filterSpecies: event.filterSpecies ?? state.filterSpecies,
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
    String? filterName,
    String? filterStatus,
    String? filterSpecies,
  }) async {
    print(
        'changeFilters.param.filterStatus=>$filterStatus filterName=> $filterName filterSpecies=> $filterSpecies');
    print(
        'changeFilters.state.filterStatus=>${state.filterStatus} filterName=> ${state.filterString} filterSpecies=>${state.filterSpecies}');

    add(HomeBlocChangeFilterEvent(
      filterName: filterName,
      filterStatus: filterStatus,
      filterSpecies: filterSpecies,
    ));
    await getNewData(
      filterName: filterName ?? state.filterString,
      filterStatus: filterStatus ?? state.filterStatus,
      filterSpecies: filterSpecies ?? state.filterSpecies,
    );

    // print('changeFilters.state.filterName=> ${state.filterName}');
    // print('changeFilters.state.filterStatus=> ${state.filterStatus}');
    // print('changeFilters.state.filterSpecies=> ${state.filterSpecies}');
  }

  Future<void> getNewData({
    String? filterName,
    String? filterStatus,
    String? filterSpecies,
  }) async {
    add(const HomeBlocHttpLoadingEvent());
    // print('getNewData.param.filterStatus=>${filterStatus}');
    await getData(
      page: 1,
      filterStatus: filterStatus,
      filterName: filterName,
      filterSpecies: filterSpecies,
    );
  }

  Future<List<ListViewModel>> getMoreData() async {
    List<ListViewModel> rta = [];
    add(const HomeBlocHttpLoadingMoreEvent());
    // print('getMoreData.filterStatus => ${state.filterStatus}');
    // print('getMoreData.page => ${state.page}');

    rta = await getData(
      page: state.page,
      filterStatus: state.filterStatus,
      filterName: state.filterString,
      filterSpecies: state.filterSpecies,
    );
    return rta;
  }

  Future<List<ListViewModel>> getData({
    required int page,
    String? filterStatus,
    String? filterName,
    String? filterSpecies,
  }) async {
    List<ListViewModel> rta = [];

    var result = await repo.getCharacterList(
      filterStatus: filterStatus,
      filterName: filterName,
      filterSpecies: filterSpecies,
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
      add(HomeBlocHttpSuccessEvent(characters: r, viewNewData: newViewData));
      return newViewData;
    });
    return rta;
  }
}
