import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/repositories/favorites/favorites.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'favorite_rhymes_event.dart';
part 'favorite_rhymes_state.dart';

class FavoriteRhymesBloc
    extends Bloc<FavoriteRhymesEvent, FavoriteRhymesState> {
  FavoriteRhymesBloc({
    required FavoritesRepositoryI favoritesRepository,
    required Talker talker,
  })  : _talker = talker,
        _favoritesRepository = favoritesRepository,
        super(FavoriteRhymesInitial()) {
    on<LoadFavoriteRhymes>(_load);
    on<DeleteFavoriteRhyme>(_toggleFavorite);
  }

  final Talker _talker;
  final FavoritesRepositoryI _favoritesRepository;

  Future<void> _load(
    LoadFavoriteRhymes event,
    Emitter<FavoriteRhymesState> emit,
  ) async {
    try {
      emit(FavoriteRhymesLoading());
      final rhymes = await _favoritesRepository.getRhymesList();
      emit(FavoriteRhymesLoaded(rhymes: rhymes));
    } catch (e, st) {
      emit(FavoriteRhymesFailure(e));
      _talker.handle(e, st);
    }
  }

  Future<void> _toggleFavorite(
    DeleteFavoriteRhyme event,
    Emitter<FavoriteRhymesState> emit,
  ) async {
    try {
      final prevState = state;
      if (prevState is! FavoriteRhymesLoaded) {
        _talker.warning('Illegal state');
        return;
      }
      final id = event.rhyme.id;
      await _favoritesRepository.delete(id);
      final favorites = [...prevState.rhymes];
      favorites.removeWhere((e) => e.id == id);
      emit(FavoriteRhymesLoaded(rhymes: favorites));
    } catch (e, st) {
      _talker.handle(e, st);
    }
  }
}
