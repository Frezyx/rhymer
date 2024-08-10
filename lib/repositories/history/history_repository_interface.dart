import 'package:rhymer/repositories/history/models/models.dart';

abstract interface class HistoryRepositoryI {
  Future<List<HistoryRhymes>> getRhymesList();
  Future<void> setRhymes(HistoryRhymes rhymes);
  Future<void> clear();
}
