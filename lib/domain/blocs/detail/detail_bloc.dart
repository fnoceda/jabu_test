import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uikit/models/custom_list_tile_model.dart';

import '../../../presentation/widgets/cache_network_image_wrapper.dart';
import '../../../utils/enums.dart';
import '../../models/character_model.dart';
import '../../repository/character_repository.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final CharacterRepository repo;
  final CachedNetworkImageWrapper imageBuilder;

  DetailBloc({
    required this.repo,
    required this.imageBuilder,
  }) : super(DetailState.initial()) {
    on<DetailFechthingEvent>((event, emit) {
      emit(state.copyWith(fetchStatus: FetchDataStatus.fetching));
    });
    on<DetailFechtFailEvent>((event, emit) {
      emit(state.copyWith(
        fetchStatus: FetchDataStatus.fail,
        errorMessage: event.errorMessage,
      ));
    });
    on<DetailFechthSuccessEvent>((event, emit) {
      emit(state.copyWith(
        fetchStatus: FetchDataStatus.success,
        character: event.character,
        viewModel: event.viewNewData,
      ));
    });
  }

  Future<void> getCharacter({required String id}) async {
    add(const DetailFechthingEvent());
    var result = await repo.getCharacterById(id: id);

    result.fold((l) {
      add(const DetailFechtFailEvent(errorMessage: 'Fail retriving data'));
    }, (r) {
      CustomListTileModel viewNewData = CustomListTileModel(
        id: r.id,
        title: r.name,
        subTitle: r.species,
        status: r.status == CharacterStatus.alive ? "alive" : "dead",
        image: imageBuilder.getImage(imgUrl: r.image),
      );
      add(DetailFechthSuccessEvent(
        character: r,
        viewNewData: viewNewData,
      ));
    });
  }
}
