// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NavigationView extends StatelessWidget {
  const NavigationView(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(
            label: 'Home',
            icon: Icon(LucideIcons.home),
          ),
          NavigationDestination(
            label: 'Settings',
            icon: Icon(LucideIcons.settings),
          ),
        ],
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}