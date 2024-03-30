import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import '../../core/core.dart';
import '../features.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                'Settings',
                style: context.theme.textTheme.headlineMedium,
              ),
              Card.outlined(
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
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
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final user = ref.read(userStateProvider).value;
                  ref.read(userStateProvider.notifier).updateUser(
                        user!.copyWith(
                          name: nameController.text,
                          email: emailController.text,
                        ),
                      );
                },
                child: const Text('Save'),
              ),
              TextButton(
                onPressed: () {
                  ref.read(authStateProvider.notifier).signOut();
                },
                child: const Text('Sign Out'),
              ),
              TextButton(
                onPressed: () {
                  ref.read(userStateProvider.notifier).deleteUser();
                },
                child: const Text('Delete Account'),
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
