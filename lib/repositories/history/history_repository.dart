import 'package:drift/drift.dart';
import 'package:rhymer/repositories/history/history.dart';
import 'package:rhymer/utils/database/drift.dart';

class HistoryRepository implements HistoryRepositoryI {
  HistoryRepository({
    required this.db,
  });

  final AppDatabase db;

  @override
  Future<List<HistoryRhyme>> getRhymesList() async {
    final data = await (db.select(db.historyRhymeModel)
          ..orderBy([
            (u) => OrderingTerm(
                  expression: u.createdAt,
                  mode: OrderingMode.desc,
                )
          ]))
        .get();
    return data.map((e) => HistoryRhyme.fromTable(e)).toList();
  }

  @override
  Future<void> createRhyme(CreateHistoryRhyme rhyme) async {
    await db.into(db.historyRhymeModel).insert(rhyme.toCompanion());
  }

  @override
  Future<void> clear() async {
    await db.delete(db.historyRhymeModel).go();
  }
}
