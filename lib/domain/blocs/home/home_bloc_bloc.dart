import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jabu_test/domain/models/character_model.dart';
import 'package:uikit/models/custom_list_tile_model.dart';

import '../../../presentation/widgets/cache_network_image_wrapper.dart';
import '../../../utils/enums.dart';
import '../../repository/character_repository.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final CharacterRepository repo;
  final CachedNetworkImageWrapper imageBuilder;
  HomeBlocBloc({required this.repo, required this.imageBuilder})
      : super(HomeBlocState.initial()) {
    on<HomeBlocEvent>((event, emit) {});
    on<HomeBlocHttpLoadingEvent>((event, emit) {
      print('emit.HomeBlocHttpLoadingEvent');
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
      print('emit.HomeBlocHttpFailEvent');
      emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          errorMessage: event.errorMessage,
        ),
      );
    });

    on<HomeBlocHttpSuccessEvent>((event, emit) {
      print('emit.HomeBlocHttpSuccessEvent');

      emit(
        state.copyWith(
            page: event.page,
            requestStatus: RequestStatus.success,
            errorMessage: '',
            characters: [...state.characters, ...event.characters],
            listViewData: [...state.listViewData, ...event.viewNewData]),
      );

      print('finish.HomeBlocHttpSuccessEvent ${state.requestStatus}');
    });

    on<HomeBlocChangeFilterEvent>((event, emit) {
      print('emit.HomeBlocChangeFilterEvent');

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
    print('getNewData.init');
    add(const HomeBlocHttpLoadingEvent());
    print('getNewData.loading');

    await getData(
      page: 1,
      filterStatus: filterStatus,
      filterString: filterString,
      filterStringType: filterStringType,
    );
    print('getNewData.finish');
  }

  Future<List<CustomListTileModel>> getMoreData() async {
    add(const HomeBlocHttpLoadingMoreEvent());

    List<CustomListTileModel> rta = await getData(
      page: state.page + 1,
      filterStatus: state.filterStatus,
      filterString: state.filterString,
      filterStringType: state.filterStringType,
    );
    return rta;
  }

  Future<List<CustomListTileModel>> getData({
    required int page,
    String? filterStatus,
    String? filterString,
    String? filterStringType,
  }) async {
    List<CustomListTileModel> rta = [];

    print('getData.init');

    var result = await repo.getCharacterList(
      page: page,
      filterStatus: filterStatus,
      filterString: filterString,
      filterStringType: filterStringType,
    );

    print('getData.repoCalled');

    rta = result.fold((l) {
      print('getData.repoFail');

      add(HomeBlocHttpFailEvent(errorMessage: l.message));
      return [];
    }, (r) {
      print('getData.repoSuccess');

      List<CustomListTileModel> newViewData = r.map((e) {
        return CustomListTileModel(
          id: e.id,
          title: e.name,
          subTitle: e.species,
          status: e.status == CharacterStatus.alive ? "alive" : "dead",
          image: imageBuilder.getImage(imgUrl: e.image),
        );
      }).toList();
      var lastPage = (r.isNotEmpty) ? state.page + 1 : state.page;
      add(HomeBlocHttpSuccessEvent(
          characters: r, viewNewData: newViewData, page: lastPage));
      return newViewData;
    });
    return rta;
  }
}
