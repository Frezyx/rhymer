import 'package:flutter/material.dart';
import 'package:rhymer/ui/ui.dart';

class StressedCharSelector extends StatelessWidget {
  const StressedCharSelector({
    super.key,
    required this.query,
    required this.stressedChars,
    required this.onCharSelected,
  });

  final String query;
  final List<String> stressedChars;
  final Function(String query) onCharSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chars = query.split('');
    return BaseConatiner(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Column(
        children: [
          Text('Укажите ударную гласную'),
          Divider(height: 16),
          RichText(
            text: TextSpan(
              children: chars.asMap().entries.map((e) {
                final char = e.value;
                final isStressedChar = stressedChars.contains(char);
                if (isStressedChar) {
                  return WidgetSpan(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: () => _onCharSelected(chars, e.key),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.primaryColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            char,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.primaryColor,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    child: Text(
                      char,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 32,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _onCharSelected(List<String> chars, int index) {
    final newQueyChars = [...chars]..insert(index + 1, '*');
    final newQuery = newQueyChars.join();
    onCharSelected(newQuery);
  }
}
