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
      initialLocation: '/settings',
      refreshListenable: Listenable.merge([
        StreamListenable(
          ref.read(
            supabaseProvider
                .select((provider) => provider.auth.onAuthStateChange),
          ),
        ),
        ValueNotifier(
          ref.watch(
            userStateProvider.select((provider) => provider.value?.id),
          ),
        ),
      ]),
      redirect: (context, state) {
        final authUser = ref.read(supabaseProvider).auth.currentSession?.user;
        if (authUser == null) {
          return '/auth';
        } else {
          final userProvider = ref.read(userStateProvider);
          if (userProvider.isLoading) {
            return null;
          }
          if (userProvider.value == null) {
            if (state.fullPath == '/auth') {
              return null;
            } else {
              return '/auth';
            }
          } else {
            if (state.fullPath == '/auth') {
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
                  routes: [
                    GoRoute(
                      path: 'profile',
                      builder: (context, state) => const ProfileView(),
                    ),
                  ],
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
      themeMode: ref.watch(userStateProvider).value?.settings.theme ??
          ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}
