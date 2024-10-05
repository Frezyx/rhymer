import 'package:rhymer/repositories/history/models/models.dart';

abstract interface class HistoryRepositoryI {
  Future<List<HistoryRhyme>> getRhymesList();
  Future<void> createRhyme(CreateHistoryRhyme rhyme);
  Future<void> clear();
}
