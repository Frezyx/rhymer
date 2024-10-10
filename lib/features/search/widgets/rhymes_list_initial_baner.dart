import 'package:flutter/material.dart';
import 'package:rhymer/ui/ui.dart';

class RhymesListInitialBanner extends StatelessWidget {
  const RhymesListInitialBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return TextBanner(
      title: 'Начни искать',
      subtitle: 'Введите слово в строку поиска,\nчтобы найти рифмы',
    );
  }
}
