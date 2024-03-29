// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Project imports:
import '../../core/core.dart';
import 'auth.dart';

class AuthView extends HookConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final authState = ref.watch(authStateProvider);
    if (authState.hasError) {
      context.showSnackBar((authState.error as AuthException).message);
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card.outlined(
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: emailController,
                    autofocus: true,
                    validator: (value) => value?.validateEmail(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
              ),
              Card.outlined(
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) => value?.validatePassword(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(LucideIcons.logIn),
                      label: const Text('Sign In'),
                      onPressed: () =>
                          ref.read(authStateProvider.notifier).signInWithEmail(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(LucideIcons.userPlus),
                      label: const Text('Sign Up'),
                      onPressed: () =>
                          ref.read(authStateProvider.notifier).signUpWithEmail(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                    ),
                  ),
                ].separated(
                  const Gap(10),
                ),
              ),
            ].separated(
              const Gap(10),
            ),
          ),
        ),
      ),
    );
  }
}
