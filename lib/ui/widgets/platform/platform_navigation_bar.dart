import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rhymer/ui/theme/theme.dart';

class PlatformNavigationBar extends StatelessWidget {
  const PlatformNavigationBar({
    super.key,
    required this.tabsRouter,
    required this.onSelect,
    required this.items,
  });

  final TabsRouter tabsRouter;
  final Function(int index) onSelect;
  final List<BottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedIndex = tabsRouter.activeIndex;

    if (theme.isAndroid) {
      return BottomNavigationBar(
        items: items,
        currentIndex: selectedIndex,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: theme.hintColor,
        onTap: onSelect,
      );
    }
    return CupertinoTabBar(
      activeColor: theme.primaryColor,
      items: items,
      currentIndex: selectedIndex,
      onTap: onSelect,
    );
  }
}
