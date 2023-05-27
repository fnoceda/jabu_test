part of 'home_cubit_cubit.dart';

class HomeCubitState extends Equatable {
  final bool loadingMoreData;
  final DataFilter dataStatusFilter;
  final SearchType searchType;
  const HomeCubitState({
    this.loadingMoreData = false,
    this.dataStatusFilter = DataFilter.all,
    this.searchType = SearchType.name,
  });

  factory HomeCubitState.initial() {
    return const HomeCubitState();
  }

  HomeCubitState copyWith({
    bool? loadingMoreData,
    DataFilter? dataStatusFilter,
    SearchType? searchType,
  }) {
    return HomeCubitState(
      loadingMoreData: loadingMoreData ?? this.loadingMoreData,
      dataStatusFilter: dataStatusFilter ?? this.dataStatusFilter,
      searchType: searchType ?? this.searchType,
    );
  }

  @override
  String toString() {
    return "HomeCubitState( loadingMoreData:$loadingMoreData , dataStatusFilter:$dataStatusFilter, searchType:$searchType)";
  }

  @override
  List<Object> get props => [loadingMoreData, dataStatusFilter, searchType];

  @override
  bool get stringify => true;
}
