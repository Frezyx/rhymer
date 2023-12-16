import 'package:flutter/material.dart';
import 'package:rhymer/ui/ui.dart';

class RhymeListCard extends StatelessWidget {
  const RhymeListCard({
    super.key,
    this.isFavorite = false,
    required this.rhyme,
    this.sourceWord,
    required this.onTap,
  });

  final String rhyme;
  final String? sourceWord;
  final bool isFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseConatiner(
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (sourceWord != null) ...[
                Text(
                  sourceWord!,
                  style: theme.textTheme.bodyLarge,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: theme.hintColor.withOpacity(0.4),
                  ),
                ),
              ],
              Text(
                rhyme,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.favorite,
              color: isFavorite
                  ? theme.primaryColor
                  : theme.hintColor.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
