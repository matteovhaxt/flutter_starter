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

class CredentialsView extends HookConsumerWidget {
  CredentialsView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final authState = ref.watch(authStateProvider);
    if (authState.hasError) {
      context.showSnackBar((authState.error as AuthException).message);
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(context.paddings.medium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    autofocus: true,
                    validator: (value) => value?.validateEmail(),
                    decoration: InputDecoration(
                      labelText: 'auth.credentials.email'.tr(),
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) => value?.validatePassword(),
                    decoration: InputDecoration(
                      labelText: 'auth.credentials.password'.tr(),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(LucideIcons.userPlus),
                  label: Text('auth.credentials.signup'.tr()),
                  onPressed: () {
                    final validation = formKey.currentState?.validate();
                    if (validation == true) {
                      ref.read(authStateProvider.notifier).signUpWithEmail(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                    }
                  },
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
    );
  }
}
