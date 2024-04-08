import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/core.dart';
import '../features.dart';

class ProfileView extends HookConsumerWidget {
  const ProfileView({super.key});

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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'profile.title'.tr(),
          style: context.theme.textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddings.medium),
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'profile.name'.tr(),
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'profile.email'.tr(),
              ),
            ),
          ].separated(
            const Gap(16),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(context.paddings.medium),
        child: ElevatedButton.icon(
          icon: const Icon(LucideIcons.save),
          label: Text('profile.save'.tr()),
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
      ),
    );
  }
}
