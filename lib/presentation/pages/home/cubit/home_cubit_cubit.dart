import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../utils/enums.dart';

part 'home_cubit_state.dart';

class HomeCubitCubit extends Cubit<HomeCubitState> {
  HomeCubitCubit() : super(HomeCubitState.initial());

  void changeDataStatusFilter(DataFilter status) {
    emit(state.copyWith(dataStatusFilter: status));
  }

  void changeSearchType(SearchType type) {
    emit(state.copyWith(searchType: type));
  }
}
