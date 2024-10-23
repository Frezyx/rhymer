import 'package:rhymer/utils/analytics/analytics.dart';

class FavoriteEvents {
  const FavoriteEvents();

  final _addToFavorites = 'add_favorite';
  final _removeFromFavorites = 'remove_favorite';

  void toggleFavorite(bool favorite) {
    Analytics.i.log(favorite ? _addToFavorites : _removeFromFavorites);
  }
}
