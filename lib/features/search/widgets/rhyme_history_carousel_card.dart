import 'package:flutter/material.dart';
import 'package:rhymer/ui/ui.dart';

class RhymeHistoryCarouselCard extends StatelessWidget {
  const RhymeHistoryCarouselCard({
    super.key,
    required this.rhymes,
    required this.word,
  });

  final String word;
  final List<String> rhymes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseConatiner(
      width: 140,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              word,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          Flexible(
            child: Text(
              rhymes.take(2).map((e) => e).join(", "),
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: theme.hintColor.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
