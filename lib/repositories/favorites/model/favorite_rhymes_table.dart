import 'package:drift/drift.dart';

class FavoriteRhymeModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get queryWord => text()();
  TextColumn get favoriteWord => text()();
  TextColumn get words => text()();
  DateTimeColumn get createdAt => dateTime()();
}
