// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:flutter_starter/env.dart';
import '../../core/core.dart';
import '../features.dart';

class SettingsView extends HookConsumerWidget {
  const SettingsView({super.key});

  void _showSelectLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.all(context.paddings.medium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: context.supportedLocales
              .map(
                (locale) => ListTile(
                  title: Text('settings.language.${locale.languageCode}'.tr()),
                  trailing: context.locale.languageCode == locale.languageCode
                      ? const Icon(LucideIcons.check)
                      : null,
                  onTap: () => context.setLocale(locale),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _showSignOutBottomSheet(BuildContext context, VoidCallback onPressed) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.all(context.paddings.medium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'settings.signout.message'.tr(),
              style: context.theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text('global.cancel'.tr()),
                  onPressed: () {
                    context.pop();
                  },
                ),
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    'global.confirm'.tr(),
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                      color: context.theme.colorScheme.error,
                    ),
                  ),
                ),
              ].separated(
                Gap(context.paddings.medium),
              ),
            )
          ].separated(
            Gap(context.paddings.medium),
          ),
        ),
      ),
    );
  }

  void _showDeleteAccountBottomSheet(
      BuildContext context, VoidCallback onPressed) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.all(context.paddings.medium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'settings.delete.message'.tr(),
              style: context.theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text('global.cancel'.tr()),
                  onPressed: () {
                    context.pop();
                  },
                ),
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    'global.confirm'.tr(),
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                      color: context.theme.colorScheme.error,
                    ),
                  ),
                ),
              ].separated(
                Gap(context.paddings.medium),
              ),
            )
          ].separated(
            Gap(context.paddings.medium),
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
              title: Text('settings.language.button'.tr()),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: () {
                _showSelectLanguageBottomSheet(context);
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
              leading: const Icon(LucideIcons.star),
              title: Text('settings.review'.tr()),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: () {
                InAppReview.instance
                    .openStoreListing(appStoreId: Env.appStoreId);
              },
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
              title: Text('settings.signout.button'.tr()),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: () {
                _showSignOutBottomSheet(context, () {
                  ref.read(authStateProvider.notifier).signOut();
                });
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
                _showDeleteAccountBottomSheet(context, () {
                  ref.read(userStateProvider.notifier).deleteUser();
                  ref.read(authStateProvider.notifier).signOut();
                });
              },
            ),
            FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        snapshot.data!.appName,
                        style: context.theme.textTheme.titleMedium,
                      ),
                      Text(
                        '${snapshot.data!.version} (${snapshot.data!.buildNumber})',
                        style: context.theme.textTheme.bodyMedium,
                      ),
                    ].separated(
                      Gap(context.paddings.small),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ].separated(
            Gap(context.paddings.small),
          ),
        ),
      ),
    );
  }
}
