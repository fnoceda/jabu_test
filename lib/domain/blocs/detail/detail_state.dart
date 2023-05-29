part of 'detail_bloc.dart';

class DetailState extends Equatable {
  final CustomListTileModel? viewModel;
  final String? errorMessage;
  final CharacterModel? character;

  final FetchDataStatus fetchStatus;

  const DetailState({
    this.errorMessage,
    this.viewModel,
    this.character,
    this.fetchStatus = FetchDataStatus.none,
  });

  factory DetailState.initial() {
    return const DetailState();
  }

  @override
  List<Object?> get props => [fetchStatus, viewModel, errorMessage, character];

  DetailState copyWith({
    FetchDataStatus? fetchStatus,
    CustomListTileModel? viewModel,
    String? errorMessage,
    CharacterModel? character,
  }) {
    return DetailState(
      fetchStatus: fetchStatus ?? this.fetchStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      character: character ?? this.character,
      viewModel: viewModel ?? this.viewModel,
    );
  }
}
