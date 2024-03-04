// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

// Project imports:
import '../features.dart';

class NavigationView extends ConsumerWidget {
  const NavigationView(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      floatingActionButton: FloatingActionButton(
        child: const Icon(LucideIcons.logOut),
        onPressed: () => ref.read(authStateProvider.notifier).signOut(),
      ),
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
