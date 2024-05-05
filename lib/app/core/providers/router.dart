// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../../features/features.dart';
import '../core.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: '/',
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
        if (state.fullPath?.startsWith('/auth') ?? false) {
          return null;
        } else {
          return '/auth';
        }
      } else {
        final userProvider = ref.read(userStateProvider);
        if (userProvider.value == null) {
          return '/auth/create-profile';
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
        path: '/loading',
        builder: (context, state) => const LoadingView(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthView(),
        routes: [
          GoRoute(
            path: 'credentials',
            builder: (context, state) => CredentialsView(),
          ),
          GoRoute(
            path: 'create-profile',
            builder: (context, state) => CreateProfileView(),
          ),
        ],
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
}
