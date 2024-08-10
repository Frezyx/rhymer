import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rhymer/ui/ui.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.description,
    required this.title,
    required this.onConfirm,
  });

  final String title;
  final String description;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.isAndroid) {
      return AlertDialog(
        backgroundColor: theme.cardColor,
        surfaceTintColor: theme.cardColor,
        content: _DialogContent(
          title: title,
          description: description,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        actions: [
          TextButton(
            onPressed: () => _confirm(context),
            child: Text(
              'Да',
              style: TextStyle(color: theme.hintColor),
            ),
          ),
          TextButton(
            onPressed: () => _close(context),
            child: const Text('Нет'),
          ),
        ],
      );
    }
    return CupertinoAlertDialog(
      content: _DialogContent(
        title: title,
        description: description,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => _confirm(context),
          isDestructiveAction: true,
          child: Text(
            'Да',
            style: TextStyle(
              color: theme.cupertinoAlertColor,
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () => _close(context),
          isDefaultAction: true,
          child: Text(
            'Нет',
            style: TextStyle(
              color: theme.cupertinoActionColor,
            ),
          ),
        ),
      ],
    );
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _confirm(BuildContext context) {
    onConfirm.call();
    Navigator.of(context).pop();
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({
    required this.crossAxisAlignment,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineSmall,
        ),
        Text(
          description,
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
