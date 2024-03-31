// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
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
        padding: EdgeInsets.symmetric(horizontal: context.paddings.medium),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: emailController,
                autofocus: true,
                validator: (value) => value?.validateEmail(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'auth.email'.tr(),
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) => value?.validatePassword(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'auth.password'.tr(),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(LucideIcons.userPlus),
                    label: Text('auth.signup'.tr()),
                    onPressed: () =>
                        ref.read(authStateProvider.notifier).signUpWithEmail(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                  ),
                  TextButton.icon(
                    icon: const Icon(LucideIcons.logIn),
                    label: Text('auth.signin'.tr()),
                    onPressed: () =>
                        ref.read(authStateProvider.notifier).signInWithEmail(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                  ),
                ],
              )
            ].separated(
              Gap(context.paddings.medium),
            ),
          ),
        ),
      ),
    );
  }
}
