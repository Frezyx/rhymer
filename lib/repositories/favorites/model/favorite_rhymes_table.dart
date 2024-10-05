import 'package:drift/drift.dart';

class FavoriteRhymeTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get queryWord => text()();
  TextColumn get favoriteWord => text()();
  TextColumn get words => text()();
  DateTimeColumn get createdAt => dateTime()();
}
