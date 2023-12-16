import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/api/api.dart';
import 'package:rhymer/api/models/models.dart';
import 'package:rhymer/repositories/history/history_repository_interface.dart';

part 'rhymes_list_event.dart';
part 'rhymes_list_state.dart';

class RhymesListBloc extends Bloc<RhymesListEvent, RhymesListState> {
  RhymesListBloc({
    required RhymerApiClient apiClient,
    required HistoryRepositoryInterface historyRepository,
  })  : _historyRepository = historyRepository,
        _apiClient = apiClient,
        super(RhymesListInitial()) {
    on<SearchRhymes>(_onSearch);
  }

  final RhymerApiClient _apiClient;
  final HistoryRepositoryInterface _historyRepository;

  Future<void> _onSearch(
    SearchRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      emit(RhymesListLoading());
      final rhymes = await _apiClient.getRhymesList(event.query);
      final historyRhyems = rhymes.toHistory(event.query);
      _historyRepository.setRhymes(historyRhyems);
      emit(RhymesListLoaded(rhymes));
    } catch (e) {
      emit(RhymesListFailure(e));
    }
  }
}
