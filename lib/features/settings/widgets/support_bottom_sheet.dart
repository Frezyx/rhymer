import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rhymer/ui/ui.dart';

class SupportBottomSheet extends StatelessWidget {
  const SupportBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.isAndroid) {
      return Padding(
        padding: const EdgeInsets.all(24).copyWith(top: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () => _close(context),
                  icon: Icon(
                    Icons.close,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                label: const Text('Написать в Telegram'),
                icon: const Icon(Icons.telegram),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.email),
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                ),
                label: const Text('Отправить Email'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      );
    }
    return CupertinoActionSheet(
      title: const Text('Поддержка'),
      message: const Text('Ответим вам быстро!'),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: Text(
            'Написать в Telegram',
            style: TextStyle(
              color: theme.cupertinoActionColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
            'Отправить Email',
            style: TextStyle(
              color: theme.cupertinoActionColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }
}
