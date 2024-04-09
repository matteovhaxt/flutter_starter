// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Project imports:
import '../../core/core.dart';
import 'auth.dart';

class AuthView extends StatefulHookConsumerWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController(
      initialPage: index,
    );
    pageController.addListener(() {
      setState(() {
        index = (pageController.page ?? 0).toInt();
      });
    });
    final authState = ref.watch(authStateProvider);
    if (authState.hasError) {
      context.showSnackBar((authState.error as AuthException).message);
    }
    ref.listen(authStateProvider, (prev, next) {
      if (next.value != null) {
        pageController.goToNextPage();
      }
    });
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            if (index > 0) {
              return IconButton(
                onPressed: () => pageController.goToPreviousPage(),
                icon: const Icon(Icons.arrow_back),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      body: PageView(
        controller: pageController,
        children: [
          StartPage(onStart: () => pageController.goToNextPage()),
          const CredentialsPage(),
          const ProfilePage(),
        ],
      ),
    );
  }
}
