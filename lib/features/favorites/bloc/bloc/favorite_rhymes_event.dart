part of 'favorite_rhymes_bloc.dart';

sealed class FavoriteRhymesEvent extends Equatable {
  const FavoriteRhymesEvent();

  @override
  List<Object> get props => [];
}

final class LoadFavoriteRhymes extends FavoriteRhymesEvent {}

final class ToggleFavoriteRhyme extends FavoriteRhymesEvent {
  const ToggleFavoriteRhyme(this.rhyme);

  final FavoriteRhyme rhyme;

  @override
  List<Object> get props => super.props..add(rhyme);
}
