import 'package:flutter/material.dart';
import 'package:rhymer/features/search/widgets/widgets.dart';
import 'package:rhymer/repositories/history/history.dart';

class RhymesHistoryCarousel extends StatelessWidget {
  const RhymesHistoryCarousel({
    super.key,
    required this.history,
    required this.onItemTap,
  });

  final List<HistoryRhyme> history;
  final Function(HistoryRhyme rhyme) onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 16),
      scrollDirection: Axis.horizontal,
      itemCount: history.length,
      separatorBuilder: (context, index) => const SizedBox(
        width: 8,
      ),
      itemBuilder: (context, index) {
        final rhymes = history[index];
        final query = rhymes.queryWord;
        return RhymeHistoryCarouselCard(
          word: query,
          rhymes: rhymes.words,
          onTap: () => onItemTap.call(rhymes),
        );
      },
    );
  }
}
