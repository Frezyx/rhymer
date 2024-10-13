import 'package:flutter/material.dart';
import 'package:rhymer/ui/ui.dart';

class EmptyFavoritesBanner extends StatelessWidget {
  const EmptyFavoritesBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return TextBanner(
      title: 'В списке пусто',
      subtitle:
          'Тут будут отображаться рифмы, которые вы\nлайкнули на странице поиска',
    );
  }
}
