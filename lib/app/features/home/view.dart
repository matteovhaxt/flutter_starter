import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:flutter_starter/app/features/features.dart';

part 'widgets/navigation_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  void onSelectIndex(int index) => setState(() => selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: NavBar(
        onSelectIndex: onSelectIndex,
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
