import 'package:drift/drift.dart';
import 'package:rhymer/repositories/favorites/favorites.dart';
import 'package:rhymer/utils/database/drift.dart';

class FavoritesRepository implements FavoritesRepositoryI {
  FavoritesRepository({required this.db});

  final AppDatabase db;

  @override
  Future<List<FavoriteRhyme>> getRhymesList() async {
    final data = await db.select(db.favoriteRhymeTable).get();
    return data.map((e) => FavoriteRhyme.fromTable(e)).toList();
  }

  @override
  Future<void> createOrDeleteRhyme(CreateFavoriteRhyme rhyme) async {
    // Проверяем, существует ли запись с такими же queryWord и favoriteWord
    final select = db.select(db.favoriteRhymeTable);
    final existingRhyme = await (select
          ..where((e) => _uniqFavoriteExpr(e, rhyme)))
        .getSingleOrNull();

    if (existingRhyme != null) {
      // Если запись существует, удаляем её
      final delete = db.delete(db.favoriteRhymeTable);
      await (delete..where((e) => e.id.equals(existingRhyme.id))).go();
      return;
    }
    // Если записи нет, создаём новую
    await createRhyme(rhyme);
  }

  @override
  Future<void> createRhyme(CreateFavoriteRhyme rhyme) async {
    await db.into(db.favoriteRhymeTable).insert(rhyme.toCompanion());
  }

  @override
  Future<void> clear() async {
    await db.delete(db.favoriteRhymeTable).go();
  }

  Expression<bool> _uniqFavoriteExpr(
    $FavoriteRhymeTableTable e,
    CreateFavoriteRhyme rhyme,
  ) =>
      Expression.and(
        [
          e.queryWord.equals(rhyme.queryWord),
          e.favoriteWord.equals(rhyme.favoriteWord)
        ],
      );
}
