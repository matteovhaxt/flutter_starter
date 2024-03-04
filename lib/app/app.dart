// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../providers.dart';
import 'core/core.dart';
import 'features/features.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      initialLocation: '/',
      refreshListenable: StreamListenable(
        ref.read(supabaseProvider).auth.onAuthStateChange,
      ),
      redirect: (context, state) {
        final user = ref.read(supabaseProvider).auth.currentSession?.user;
        if (user == null) {
          return '/auth';
        } else {
          if (state.fullPath == '/auth') {
            return '/';
          } else {
            return null;
          }
        }
      },
      routes: [
        GoRoute(
          path: '/auth',
          builder: (context, state) => const AuthView(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              NavigationView(navigationShell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) => const HomeView(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/settings',
                  builder: (context, state) => const Scaffold(
                    body: Center(
                      child: Text('Settings'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
    return MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: ThemeMode.dark,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}
