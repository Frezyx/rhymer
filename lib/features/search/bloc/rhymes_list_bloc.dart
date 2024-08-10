import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/api/api.dart';
import 'package:rhymer/api/models/models.dart';
import 'package:rhymer/repositories/favorites/favorites.dart';
import 'package:rhymer/repositories/history/history_repository_interface.dart';

part 'rhymes_list_event.dart';
part 'rhymes_list_state.dart';

class RhymesListBloc extends Bloc<RhymesListEvent, RhymesListState> {
  RhymesListBloc({
    required RhymerApiClient apiClient,
    required HistoryRepositoryI historyRepository,
    required FavoritesRepositoryI favoritesRepositoryInterface,
  })  : _historyRepository = historyRepository,
        _favoritesRepository = favoritesRepositoryInterface,
        _apiClient = apiClient,
        super(RhymesListInitial()) {
    on<SearchRhymes>(_onSearch);
    on<ToggleFavoriteRhymes>(_onToggleFavorite);
  }

  final RhymerApiClient _apiClient;
  final HistoryRepositoryI _historyRepository;
  final FavoritesRepositoryI _favoritesRepository;

  Future<void> _onSearch(
    SearchRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      emit(RhymesListLoading());
      final rhymes = await _apiClient.getRhymesList(event.query);
      final historyRhyems = rhymes.toHistory(event.query);
      await _historyRepository.setRhymes(historyRhyems);
      final favoriteRhymes = await _favoritesRepository.getRhymesList();
      emit(
        RhymesListLoaded(
          rhymes: rhymes,
          query: event.query,
          favoriteRhymes: favoriteRhymes,
        ),
      );
    } catch (e) {
      emit(RhymesListFailure(e));
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
      await _favoritesRepository.createOrDeleteRhymes(
        event.rhymes.toFavorite(event.query, event.favoriteWord),
      );
      final favoriteRhymes = await _favoritesRepository.getRhymesList();
      emit(prevState.copyWith(favoriteRhymes: favoriteRhymes));
    } catch (e) {
      emit(RhymesListFailure(e));
    } finally {
      event.completer?.complete();
    }
  }
}
