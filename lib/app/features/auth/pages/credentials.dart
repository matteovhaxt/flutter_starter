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
import '../auth.dart';
import '../../../core/core.dart';

class CredentialsPage extends HookConsumerWidget {
  const CredentialsPage({super.key});

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
                  labelText: 'auth.credentials.email'.tr(),
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) => value?.validatePassword(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'auth.credentials.password'.tr(),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(LucideIcons.userPlus),
                    label: Text('auth.credentials.signup'.tr()),
                    onPressed: () =>
                        ref.read(authStateProvider.notifier).signUpWithEmail(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                  ),
                  TextButton.icon(
                    icon: const Icon(LucideIcons.logIn),
                    label: Text('auth.credentials.signin'.tr()),
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
