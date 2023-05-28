part of 'home_cubit_cubit.dart';

class HomeCubitState extends Equatable {
  final DataFilter dataStatusFilter;
  final SearchType searchType;
  const HomeCubitState({
    this.dataStatusFilter = DataFilter.all,
    this.searchType = SearchType.name,
  });

  factory HomeCubitState.initial() {
    return const HomeCubitState();
  }

  HomeCubitState copyWith({
    DataFilter? dataStatusFilter,
    SearchType? searchType,
  }) {
    return HomeCubitState(
      dataStatusFilter: dataStatusFilter ?? this.dataStatusFilter,
      searchType: searchType ?? this.searchType,
    );
  }

  @override
  String toString() {
    return "HomeCubitState(  dataStatusFilter:$dataStatusFilter, searchType:$searchType)";
  }

  @override
  List<Object> get props => [dataStatusFilter, searchType];

  @override
  bool get stringify => true;
}
