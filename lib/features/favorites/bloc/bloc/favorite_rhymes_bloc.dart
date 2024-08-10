import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/repositories/favorites/favorites.dart';

part 'favorite_rhymes_event.dart';
part 'favorite_rhymes_state.dart';

class FavoriteRhymesBloc
    extends Bloc<FavoriteRhymesEvent, FavoriteRhymesState> {
  FavoriteRhymesBloc({
    required FavoritesRepositoryI favoritesRepository,
  })  : _favoritesRepository = favoritesRepository,
        super(FavoriteRhymesInitial()) {
    on<LoadFavoriteRhymes>(_load);
    on<ToggleFavoriteRhyme>(_toggleFavorite);
  }

  final FavoritesRepositoryI _favoritesRepository;

  Future<void> _load(
    LoadFavoriteRhymes event,
    Emitter<FavoriteRhymesState> emit,
  ) async {
    try {
      emit(FavoriteRhymesLoading());
      final rhymes = await _favoritesRepository.getRhymesList();
      emit(FavoriteRhymesLoaded(rhymes: rhymes));
    } catch (e) {
      emit(FavoriteRhymesFailure(e));
    }
  }

  Future<void> _toggleFavorite(
    ToggleFavoriteRhyme event,
    Emitter<FavoriteRhymesState> emit,
  ) async {
    try {
      _favoritesRepository.createOrDeleteRhymes(event.favoriteRhyme);
      add(LoadFavoriteRhymes());
    } catch (e) {
      log(e.toString());
    }
  }
}
