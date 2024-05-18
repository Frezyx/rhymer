import 'package:realm/realm.dart';
import 'package:rhymer/repositories/favorites/favorites.dart';

class FavoritesRepository implements FavoritesRepositoryI {
  FavoritesRepository({
    required this.realm,
  });

  final Realm realm;

  @override
  Future<List<FavoriteRhymes>> getRhymesList() async {
    return realm.all<FavoriteRhymes>().toList();
  }

  @override
  Future<void> createOrDeleteRhymes(FavoriteRhymes rhymes) async {
    final rhymesList = realm.query<FavoriteRhymes>(
      "queryWord == '${rhymes.queryWord}' AND favoriteWord == '${rhymes.favoriteWord}'",
    );
    if (rhymesList.isNotEmpty) {
      for (var e in rhymesList) {
        realm.write(() => realm.delete(e));
      }
      return;
    }
    realm.write(() => realm.add(rhymes));
  }

  @override
  Future<void> clear() async {
    realm.write(() => realm.deleteAll<FavoriteRhymes>());
  }
}
