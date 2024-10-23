import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/repositories/favorites/favorites.dart';
import 'package:rhymer/repositories/history/history.dart';
import 'package:rhymer/repositories/rhymes/rhymes.dart';
import 'package:rhymer/utils/extensions/extensions.dart';

part 'rhymes_list_event.dart';
part 'rhymes_list_state.dart';

class RhymesListBloc extends Bloc<RhymesListEvent, RhymesListState> {
  RhymesListBloc({
    required RhymesRepositoryI rhymesRepository,
    required HistoryRepositoryI historyRepository,
    required FavoritesRepositoryI favoritesRepositoryInterface,
  })  : _historyRepository = historyRepository,
        _favoritesRepository = favoritesRepositoryInterface,
        _rhymesRepository = rhymesRepository,
        super(RhymesListInitial()) {
    on<SearchRhymes>(_onSearch);
    on<ToggleFavoriteRhymes>(_onToggleFavorite);
  }

  final RhymesRepositoryI _rhymesRepository;
  final HistoryRepositoryI _historyRepository;
  final FavoritesRepositoryI _favoritesRepository;

  Future<void> _onSearch(
    SearchRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      emit(RhymesListLoading());
      final rhymesDto = await _rhymesRepository.fetchRhymesList(event.query);
      final words = rhymesDto.rhymes;
      if (words == null || words.isEmpty) {
        final stressedChars = rhymesDto.stressedChars;
        if (stressedChars != null && stressedChars.isNotEmpty) {
          emit(
            RhymesStressedCharsSelection(
              stressedChars: stressedChars,
              query: event.query,
            ),
          );
          return;
        }
        return;
      }

      final rhymes = Rhymes(rhymes: words);
      if (event.addToHistory) {
        final createHistoryRhyme = CreateHistoryRhyme.create(
          queryWord: event.query,
          words: words,
        );
        await _historyRepository.createRhyme(createHistoryRhyme);
      }

      final favoriteRhymes = await _favoritesRepository.getRhymesList();
      emit(
        RhymesListLoaded(
          rhymes: rhymes,
          query: event.query,
          favorites: favoriteRhymes,
        ),
      );
    } catch (e) {
      emit(RhymesListFailure(e));
      log(e.toString());
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      final prevState = state;
      if (prevState is! RhymesListLoaded) {
        log('state is not RhymesListLoaded');
        return;
      }
      final createModel = CreateFavoriteRhyme.create(
        queryWord: prevState.query,
        favoriteWord: event.favoriteWord,
        words: event.rhymes.rhymes,
      );
      await _favoritesRepository.createOrDeleteRhyme(createModel);
      final favorites = await _favoritesRepository.getRhymesList();
      emit(prevState.copyWith(favorites: favorites));
    } catch (e) {
      emit(RhymesListFailure(e));
    } finally {
      event.completer?.complete();
    }
  }
}
