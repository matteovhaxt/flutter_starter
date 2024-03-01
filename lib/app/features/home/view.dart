import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 1;

  void onSelectItem(int index) => setState(() => selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: _buildNavigationBar(onSelectItem),
      body: _buildBody(selectedIndex),
    );
  }
}

Widget _buildBody(int index) {
  return IndexedStack(
    index: index,
    children: [
      Expanded(
        child: Container(
          color: Colors.red,
        ),
      ),
      Expanded(
        child: Container(
          color: Colors.blue,
        ),
      ),
      Expanded(
        child: Container(
          color: Colors.green,
        ),
      ),
    ],
  );
}

Widget _buildNavigationBar(void Function(int) onSelectItem) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: NavigationBar(
      destinations: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => onSelectItem(0),
        ),
        IconButton(
          icon: const Icon(Icons.chat),
          onPressed: () => onSelectItem(1),
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => onSelectItem(2),
        ),
      ],
    ),
  );
}
