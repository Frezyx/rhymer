import 'package:realm/realm.dart';

part 'favorite_rhymes.g.dart';

@RealmModel()
class _FavoriteRhymes {
  @PrimaryKey()
  late String id;
  late String queryWord;
  late String favoriteWord;
  late DateTime createdAt;
  late List<String> words;
}
