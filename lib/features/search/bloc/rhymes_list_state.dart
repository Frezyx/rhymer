part of 'rhymes_list_bloc.dart';

sealed class RhymesListState extends Equatable {
  const RhymesListState();

  @override
  List<Object> get props => [];
}

final class RhymesListInitial extends RhymesListState {}

final class RhymesListLoading extends RhymesListState {}

final class RhymesListLoaded extends RhymesListState {
  const RhymesListLoaded(this.rhymes);

  final Rhymes rhymes;

  @override
  List<Object> get props => super.props..add(rhymes);
}

final class RhymesListFailure extends RhymesListState {
  const RhymesListFailure(this.error);
  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
