import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;

    switch (location) {
      case '/':
        return 0;
      case '/categories':
        return 1;
      case '/favorites':
        return 2;
      default:
        return 0;
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/');
        break;
      case 2:
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      elevation: 0,
      selectedIndex: getCurrentIndex(context),
      onDestinationSelected: (index) => _onItemTapped(context, index),
      indicatorColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      destinations: const [
        _CustomNavigationDestination(
          label: 'Home',
          icon: Icons.home_outlined,
          selectedIcon: Icons.home,
        ),
        _CustomNavigationDestination(
          label: 'Categories',
          icon: Icons.label_outline,
          selectedIcon: Icons.label,
        ),
        _CustomNavigationDestination(
          label: 'Favorites',
          icon: Icons.favorite_outline,
          selectedIcon: Icons.favorite,
        ),
      ],
    );
  }
}

class _CustomNavigationDestination extends StatelessWidget {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const _CustomNavigationDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      label: label,
      icon: Icon(icon, color: Theme.of(context).colorScheme.primary),
      selectedIcon:
          Icon(selectedIcon, color: Theme.of(context).colorScheme.primary),
    );
  }
}
