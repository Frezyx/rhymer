import 'package:flutter/material.dart';
import 'package:rhymer/ui/ui.dart';

class EmptyHistoryBanner extends StatelessWidget {
  const EmptyHistoryBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return TextBanner(
      title: 'В списке пусто',
      subtitle: 'Тут будет отображаться история поиска',
    );
  }
}
