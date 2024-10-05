import 'package:drift/drift.dart';

class HistoryRhymeModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get queryWord => text()();
  TextColumn get words => text()();
  DateTimeColumn get createdAt => dateTime()();
}
