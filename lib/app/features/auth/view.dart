import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth.dart';
import 'package:flutter_starter/app/core/core.dart';

class AuthView extends HookConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          heightFactor: .3,
          widthFactor: .3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) => value?.validateEmail(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: passwordController,
                validator: (value) => value?.validatePassword(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              ElevatedButton(
                child: authState.when(
                  data: (value) => Text(value?.user.email ?? 'Sign Up'),
                  error: (error, _) => Text((error as AuthException).message),
                  loading: () => const CircularProgressIndicator(),
                ),
                onPressed: () =>
                    ref.read(authStateProvider.notifier).signUpWithEmail(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
              )
            ].separated(
              const Gap(10),
            ),
          ),
        ),
      ),
    );
  }
}
