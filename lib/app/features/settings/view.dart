// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../../core/core.dart';
import '../features.dart';

class SettingsView extends HookConsumerWidget {
  const SettingsView({super.key});
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
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'settings.headline'.tr(),
                style: context.theme.textTheme.headlineMedium,
              ),
              Card.outlined(
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'settings.name'.tr(),
                    ),
                  ),
                ),
              ),
              Card.outlined(
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'settings.email'.tr(),
                    ),
                  ),
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
              TextButton(
                child: Text('settings.signout'.tr()),
                onPressed: () {
                  ref.read(authStateProvider.notifier).signOut();
                },
              ),
              TextButton(
                child: Text(
                  'settings.delete_account.button'.tr(),
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: context.theme.colorScheme.error,
                  ),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('settings.delete_account.message'.tr()),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: Text(
                                        'settings.delete_account.cancel'.tr()),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      ref
                                          .read(userStateProvider.notifier)
                                          .deleteUser();
                                      ref
                                          .read(authStateProvider.notifier)
                                          .signOut();
                                    },
                                    child: Text(
                                      'settings.delete_account.confirm'.tr(),
                                      style: context.theme.textTheme.bodyMedium
                                          ?.copyWith(
                                        color: context.theme.colorScheme.error,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
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
