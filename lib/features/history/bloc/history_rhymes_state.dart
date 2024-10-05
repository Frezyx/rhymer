part of 'history_rhymes_bloc.dart';

sealed class HistoryRhymesState extends Equatable {
  const HistoryRhymesState();

  @override
  List<Object> get props => [];
}

final class HistoryRhymesInitial extends HistoryRhymesState {}

final class HistoryRhymesLoading extends HistoryRhymesState {}

final class HistoryRhymesLoaded extends HistoryRhymesState {
  const HistoryRhymesLoaded({required this.rhymes});

  final List<HistoryRhyme> rhymes;

  @override
  List<Object> get props => super.props..add(rhymes);
}

final class HistoryRhymesFailure extends HistoryRhymesState {
  const HistoryRhymesFailure(this.error);
  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
