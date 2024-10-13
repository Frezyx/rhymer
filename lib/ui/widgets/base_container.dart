import 'package:flutter/material.dart';

class BaseConatiner extends StatelessWidget {
  const BaseConatiner({
    super.key,
    required this.child,
    this.width,
    this.margin,
    this.padding = const EdgeInsets.all(8),
  });

  final double? width;
  final EdgeInsets? margin;
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
