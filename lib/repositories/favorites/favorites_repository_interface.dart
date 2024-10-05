import 'package:rhymer/repositories/favorites/favorites.dart';

abstract interface class FavoritesRepositoryI {
  Future<List<FavoriteRhyme>> getRhymesList();
  Future<void> createOrDeleteRhyme(CreateFavoriteRhyme rhyme);
  Future<void> clear();
}
