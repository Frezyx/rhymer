part of 'rhymes_list_bloc.dart';

sealed class RhymesListEvent extends Equatable {
  const RhymesListEvent();

  @override
  List<Object?> get props => [];
}

class SearchRhymes extends RhymesListEvent {
  const SearchRhymes({
    required this.query,
    this.addToHistory = true,
  });

  final String query;
  final bool addToHistory;

  @override
  List<Object?> get props => super.props..addAll([query, addToHistory]);
}

class ToggleFavoriteRhymes extends RhymesListEvent {
  const ToggleFavoriteRhymes({
    required this.favorite,
    required this.rhymes,
    required this.favoriteWord,
    this.completer,
  });

  final FavoriteRhyme? favorite;
  final String favoriteWord;
  final Rhymes rhymes;
  final Completer? completer;

  bool get isFavorite => favorite != null;

  @override
  List<Object?> get props => super.props
    ..addAll([
      favorite,
      rhymes,
      favoriteWord,
      completer,
    ]);
}
