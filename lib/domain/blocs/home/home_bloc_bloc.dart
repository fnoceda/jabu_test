import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jabu_test_bloc/data/repository/character_repository.dart';
import 'package:jabu_test_bloc/domain/models/character_model.dart';
import 'package:jabu_test_bloc/locator.dart';
import 'package:jabu_test_bloc/presentation/models/list_view_model.dart';

import '../../../presentation/widgets/cache_network_image_wrapper.dart';
import '../../../utils/enums.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final CharacterRepository repo;
  HomeBlocBloc({required this.repo}) : super(HomeBlocState.initial()) {
    on<HomeBlocEvent>((event, emit) {});
    on<HomeBlocHttpLoadingEvent>((event, emit) {
      emit(state.copyWith(
        requestStatus: RequestStatus.loading,
        listViewData: [],
        characters: [],
      ));
    });

    on<HomeBlocHttpLoadingMoreEvent>((event, emit) {
      emit(state.copyWith(requestStatus: RequestStatus.more));
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
      emit(
        state.copyWith(
            page: event.page,
            requestStatus: RequestStatus.success,
            errorMessage: '',
            characters: [...state.characters, ...event.characters],
            listViewData: [...state.listViewData, ...event.viewNewData]),
      );
    });

    on<HomeBlocChangeFilterEvent>((event, emit) {
      emit(state.copyWith(
        page: 1,
        filterString: event.filterString ?? state.filterString,
        filterStatus: event.filterStatus ?? state.filterStatus,
        filterStringType: event.filterStringType ?? state.filterStringType,
      ));
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
      await getNewData(
        filterString: filterString ?? state.filterString,
        filterStatus: filterStatus ?? state.filterStatus,
        filterStringType: filterStringType ?? state.filterStringType,
      );
    }
  }

  Future<void> getNewData({
    String? filterString,
    String? filterStatus,
    String? filterStringType,
  }) async {
    add(const HomeBlocHttpLoadingEvent());

    await getData(
      page: 1,
      filterStatus: filterStatus,
      filterString: filterString,
      filterStringType: filterStringType,
    );
  }

  Future<List<ListViewModel>> getMoreData() async {
    add(const HomeBlocHttpLoadingMoreEvent());

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
          id: e.id,
          title: e.name,
          subTitle: e.species,
          status: e.status == CharacterStatus.alive ? "alive" : "dead",
          image: Locator.sl
              .get<CachedNetworkImageWrapper>()
              .getImage(imgUrl: e.image),
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
