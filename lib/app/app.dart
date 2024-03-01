import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/core.dart';
import 'features/features.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      refreshListenable: StreamListenable(
        Supabase.instance.client.auth.onAuthStateChange,
      ),
      redirect: (context, state) {
        final user = Supabase.instance.client.auth.currentSession?.user;
        if (user == null) {
          return '/auth';
        } else {
          return '/';
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
