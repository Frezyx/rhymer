import 'package:flutter/material.dart';
import 'package:rhymer/ui/ui.dart';

class SearchRhymesBottomSheet extends StatelessWidget {
  const SearchRhymesBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseBottomSheet(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.hintColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Начни вводить слово...',
                        hintStyle:
                            TextStyle(color: theme.hintColor.withOpacity(0.5)),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                title: const Text('Слово из автокомплита'),
                onTap: () {},
              ),
              separatorBuilder: (context, _) => const Divider(height: 1),
              itemCount: 15,
            ),
          ),
        ],
      ),
    );
  }
}
