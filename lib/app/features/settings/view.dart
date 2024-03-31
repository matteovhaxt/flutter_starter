// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

// Project imports:
import '../../core/core.dart';
import '../features.dart';

class SettingsView extends HookConsumerWidget {
  const SettingsView({super.key});

  void _showDeleteAccountDialog(BuildContext context, VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: EdgeInsets.all(context.paddings.medium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'settings.delete_account.message'.tr(),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: Text('settings.delete_account.cancel'.tr()),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  TextButton(
                    onPressed: onPressed,
                    child: Text(
                      'settings.delete_account.confirm'.tr(),
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: context.theme.colorScheme.error,
                      ),
                    ),
                  ),
                ].separated(
                  Gap(context.paddings.medium),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController.fromValue(
      TextEditingValue(text: ref.read(userStateProvider).value!.name),
    );
    final emailController = useTextEditingController.fromValue(
      TextEditingValue(text: ref.read(userStateProvider).value!.email),
    );
    final userState = ref.read(userStateProvider);
    if (userState.hasError) {
      context.showSnackBar(userState.error.toString());
    }
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddings.medium),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'settings.headline'.tr(),
                style: context.theme.textTheme.headlineMedium,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'settings.name'.tr(),
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'settings.email'.tr(),
                ),
              ),
              ElevatedButton(
                child: Text('settings.save'.tr()),
                onPressed: () {
                  final user = ref.read(userStateProvider).value;
                  ref.read(userStateProvider.notifier).updateUser(
                        user!.copyWith(
                          name: nameController.text,
                          email: emailController.text,
                        ),
                      );
                  ref.read(authStateProvider.notifier).updateUser(
                        emailController.text,
                      );
                },
              ),
              TextButton.icon(
                icon: const Icon(LucideIcons.logOut),
                label: Text('settings.signout'.tr()),
                onPressed: () {
                  ref.read(authStateProvider.notifier).signOut();
                },
              ),
              TextButton.icon(
                icon: Icon(
                  LucideIcons.userX,
                  color: context.theme.colorScheme.error,
                ),
                label: Text(
                  'settings.delete_account.button'.tr(),
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: context.theme.colorScheme.error,
                  ),
                ),
                onPressed: () {
                  _showDeleteAccountDialog(context, () {
                    ref.read(userStateProvider.notifier).deleteUser();
                    ref.read(authStateProvider.notifier).signOut();
                  });
                },
              ),
            ].separated(
              const Gap(16),
            ),
          ),
        ),
      ),
    );
  }
}
