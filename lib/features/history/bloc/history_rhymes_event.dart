part of 'history_rhymes_bloc.dart';

sealed class HistoryRhymesEvent extends Equatable {
  const HistoryRhymesEvent();

  @override
  List<Object> get props => [];
}

final class LoadHistoryRhymes extends HistoryRhymesEvent {}

final class ClearRhymesHistory extends HistoryRhymesEvent {}
