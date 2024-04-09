// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final isDarkTheme = ref.watch(userStateProvider
            .select((provider) => provider.value?.settings.theme)) ==
        ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settings.title'.tr(),
          style: context.theme.textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddings.medium),
        child: ListView(
          children: [
            Row(
              children: [
                Text('settings.general'.tr()),
                const Flexible(child: Divider()),
              ].separated(
                Gap(context.paddings.small),
              ),
            ),
            ListTile(
              leading: const Icon(LucideIcons.user),
              title: Text('settings.profile'.tr()),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: () {
                context.go('/settings/profile');
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.globe),
              title: Text('settings.language'.tr()),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: () {
                context.showSnackBar('Work in progress');
              },
            ),
            ListTile(
              leading: Icon(
                isDarkTheme ? LucideIcons.moon : LucideIcons.sun,
              ),
              title: Text(
                isDarkTheme
                    ? 'settings.dark_theme'.tr()
                    : 'settings.light_theme'.tr(),
              ),
              trailing: Switch.adaptive(
                value: isDarkTheme,
                onChanged: (value) {
                  final user = ref.read(userStateProvider).value;
                  ref.read(userStateProvider.notifier).updateUser(
                        user!.copyWith(
                          settings: user.settings.copyWith(
                            theme: value ? ThemeMode.dark : ThemeMode.light,
                          ),
                        ),
                      );
                },
              ),
            ),
            Row(
              children: [
                Text('settings.about'.tr()),
                const Flexible(child: Divider()),
              ].separated(
                Gap(context.paddings.small),
              ),
            ),
            ListTile(
              leading: const Icon(LucideIcons.bug),
              title: Text('settings.bug'.tr()),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: () {
                launchUrl(
                  Uri.parse(
                      'https://github.com/matteovhaxt/flutter_starter/issues'),
                );
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.github),
              title: Text('settings.source'.tr()),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: () {
                launchUrl(
                  Uri.parse('https://github.com/matteovhaxt/flutter_starter'),
                );
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.logOut),
              title: Text('settings.signout'.tr()),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: () {
                ref.read(authStateProvider.notifier).signOut();
              },
            ),
            ListTile(
              leading: Icon(
                LucideIcons.userX,
                color: context.theme.colorScheme.error,
              ),
              title: Text(
                'settings.delete.button'.tr(),
                style: context.theme.textTheme.titleMedium?.copyWith(
                  color: context.theme.colorScheme.error,
                ),
              ),
              trailing: Icon(
                LucideIcons.chevronRight,
                color: context.theme.colorScheme.error,
              ),
              onTap: () {
                _showDeleteAccountDialog(context, () {
                  ref.read(userStateProvider.notifier).deleteUser();
                  ref.read(authStateProvider.notifier).signOut();
                });
              },
            ),
          ].separated(
            Gap(context.paddings.small),
          ),
        ),
      ),
    );
  }
}
