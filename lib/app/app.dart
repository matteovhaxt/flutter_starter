// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'core/core.dart';
import 'features/features.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      initialLocation: '/',
      refreshListenable: Listenable.merge([
        StreamListenable(ref.read(supabaseProvider).auth.onAuthStateChange),
        ValueNotifier(ref.watch(userStateProvider).value),
      ]),
      redirect: (context, state) {
        final authUser = ref.read(supabaseProvider).auth.currentSession?.user;
        if (authUser == null) {
          return '/auth';
        } else {
          final user = ref.read(userStateProvider).value;
          if (user == null) {
            return '/signup';
          } else {
            if (state.fullPath == '/auth' || state.fullPath == '/signup') {
              return '/';
            } else {
              return null;
            }
          }
        }
      },
      routes: [
        GoRoute(
          path: '/auth',
          builder: (context, state) => const AuthView(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignupView(),
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
                  builder: (context, state) => const SettingsView(),
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
