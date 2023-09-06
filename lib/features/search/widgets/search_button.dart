import 'package:flutter/material.dart';

class SearchButtion extends StatelessWidget {
  const SearchButtion({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.hintColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded),
          const SizedBox(width: 12),
          Text(
            'Поиск рифм...',
            style: TextStyle(
              fontSize: 18,
              color: theme.hintColor.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
