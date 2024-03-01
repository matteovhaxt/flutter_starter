part of '../view.dart';

class NavBar extends ConsumerWidget {
  const NavBar({required this.onSelectIndex, super.key});

  final void Function(int index) onSelectIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const List<IconData> items = [
      LucideIcons.database,
      LucideIcons.messageCircle,
      LucideIcons.settings,
    ];
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...items.map(
            (icon) {
              final index = items.indexOf(icon);
              return IconButton(
                icon: Icon(icon),
                onPressed: () => onSelectIndex(index),
              );
            },
          ),
          IconButton(
            icon: const Icon(LucideIcons.logOut),
            onPressed: () => ref.read(authStateProvider.notifier).signOut(),
          ),
        ],
      ),
    );
  }
}
