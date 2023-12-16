import 'package:rhymer/repositories/favorites/model/favorite_rhymes.dart';

abstract interface class FavoritesRepositoryInterface {
  Future<List<FavoriteRhymes>> getRhymesList();
  Future<void> createOrDeleteRhymes(FavoriteRhymes rhymes);
  Future<void> clear();
}
