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
      destinations: const [
        NavigationDestination(
          label: 'Home',
          icon: _NavigationIcon(Icons.home_outlined),
          selectedIcon: _NavigationIcon(Icons.home),
        ),
        NavigationDestination(
          label: 'Categories',
          icon: _NavigationIcon(Icons.label_outline),
          selectedIcon: _NavigationIcon(Icons.label),
        ),
        NavigationDestination(
          label: 'Favorites',
          icon: _NavigationIcon(Icons.favorite_outline),
          selectedIcon: _NavigationIcon(Icons.favorite),
        ),
      ],
    );
  }
}

class _NavigationIcon extends StatelessWidget {
  final IconData icon;

  const _NavigationIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
