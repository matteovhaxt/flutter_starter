import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

import 'features/features.dart';

part 'router.g.dart';

@riverpod
class Router extends _$Router {
  @override
  GoRouter build() => GoRouter(
        redirect: (context, state) {
          final user = ref.watch(authStateProvider).asData?.value;
          if (user == null) {
            return '/auth';
          } else {
            if (state.path == 'login-callback') {
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
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeView(),
          ),
        ],
        errorBuilder: (context, state) => Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
            ),
          ),
        ),
      );
}
