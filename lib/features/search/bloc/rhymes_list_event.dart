part of 'rhymes_list_bloc.dart';

sealed class RhymesListEvent extends Equatable {
  const RhymesListEvent();

  @override
  List<Object?> get props => [];
}

class SearchRhymes extends RhymesListEvent {
  const SearchRhymes({required this.query});

  final String query;

  @override
  List<Object?> get props => super.props..addAll([query]);
}

class ToggleFavoriteRhymes extends RhymesListEvent {
  const ToggleFavoriteRhymes({
    required this.rhymes,
    required this.query,
    required this.favoriteWord,
    this.completer,
  });

  final String query;
  final String favoriteWord;
  final Rhymes rhymes;
  final Completer? completer;

  @override
  List<Object?> get props =>
      super.props..addAll([rhymes, favoriteWord, query, completer]);
}
