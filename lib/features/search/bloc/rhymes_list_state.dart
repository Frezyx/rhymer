part of 'rhymes_list_bloc.dart';

sealed class RhymesListState extends Equatable {
  const RhymesListState();

  @override
  List<Object> get props => [];
}

final class RhymesListInitial extends RhymesListState {}

final class RhymesListLoading extends RhymesListState {}

final class RhymesListLoaded extends RhymesListState {
  const RhymesListLoaded({
    required this.rhymes,
    required this.query,
    required this.favorites,
  });

  final String query;
  final Rhymes rhymes;
  final List<FavoriteRhyme> favorites;

  FavoriteRhyme? favorite(String rhyme) {
    return favorites.firstWhereOrNull(
      (e) => e.favoriteWord == rhyme && e.queryWord == query,
    );
  }

  @override
  List<Object> get props => super.props..addAll([rhymes, query, favorites]);

  RhymesListLoaded copyWith({
    String? query,
    Rhymes? rhymes,
    List<FavoriteRhyme>? favorites,
  }) {
    return RhymesListLoaded(
      query: query ?? this.query,
      rhymes: rhymes ?? this.rhymes,
      favorites: favorites ?? this.favorites,
    );
  }
}

final class RhymesStressedCharsSelection extends RhymesListState {
  const RhymesStressedCharsSelection({
    required this.stressedChars,
    required this.query,
  });

  final String query;
  final List<String> stressedChars;

  @override
  List<Object> get props => super.props..addAll([stressedChars, query]);
}

final class RhymesListFailure extends RhymesListState {
  const RhymesListFailure(this.error);
  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
