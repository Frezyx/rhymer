import 'package:rhymer/repositories/favorites/favorites.dart';

abstract interface class FavoritesRepositoryI {
  Future<List<FavoriteRhyme>> getRhymesList();
  Future<void> createRhyme(CreateFavoriteRhyme rhymes);
  Future<void> createOrDeleteRhyme(CreateFavoriteRhyme rhymes);
  Future<void> clear();
}
