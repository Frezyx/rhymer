import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rhymer/ui/ui.dart';

class RhymeListCard extends StatelessWidget {
  const RhymeListCard({
    super.key,
    required this.rhyme,
    required this.onLikeTap,
    this.id,
    this.isFavorite = false,
    this.sourceWord,
    this.onCopied,
  });

  final int? id;
  final String rhyme;
  final String? sourceWord;
  final bool isFavorite;
  final VoidCallback onLikeTap;
  final VoidCallback? onCopied;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => _onTap(context),
      child: BaseConatiner(
        margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
        padding: EdgeInsets.only(left: 12),
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
                SelectableText(
                  rhyme,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  onTap: () => _onTap(context),
                ),
              ],
            ),
            IconButton(
              onPressed: onLikeTap,
              icon: Icon(
                Icons.favorite,
                color: isFavorite
                    ? theme.primaryColor
                    : theme.hintColor.withOpacity(0.2),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    HapticFeedback.lightImpact();
    Clipboard.setData(ClipboardData(text: rhyme));
    final colorScheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check, color: colorScheme.onPrimaryFixed),
            SizedBox(width: 16),
            Text(
              'Рифма скопированана',
              style: TextStyle(color: colorScheme.onPrimaryFixed),
            ),
          ],
        ),
        backgroundColor: colorScheme.primaryFixed,
      ),
    );
    onCopied?.call();
  }
}
