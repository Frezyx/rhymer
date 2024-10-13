import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  var _showSuffix = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Focus(
      onFocusChange: (value) => _onFocusChanged(value),
      child: TextField(
        controller: widget.controller,
        textInputAction: TextInputAction.search,
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
          hintText: 'Начни вводить слово...',
          hintStyle: TextStyle(
            color: theme.hintColor.withOpacity(0.5),
            fontWeight: FontWeight.w400,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          suffixIcon: _showSuffix
              ? IconButton(
                  onPressed: _clearText,
                  icon: Icon(Icons.close, size: 22),
                )
              : null,
        ),
      ),
    );
  }

  void _clearText() {
    widget.controller.clear();
  }

  void _onFocusChanged(bool value) {
    if (!value && widget.controller.text.isNotEmpty) {
      return;
    }
    setState(() => _showSuffix = value);
  }
}
