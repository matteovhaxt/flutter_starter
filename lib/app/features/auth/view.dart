// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

// Project imports:
import '../../core/core.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(context.paddings.medium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              LucideIcons.rocket,
              size: 40,
            ),
            Column(
              children: [
                Text(
                  'auth.start.headline'.tr(),
                  style: context.theme.textTheme.headlineMedium,
                ),
                Text(
                  'auth.start.caption'.tr(),
                  style: context.theme.textTheme.labelMedium,
                ),
              ].separated(
                Gap(context.paddings.medium),
              ),
            ),
            ElevatedButton(
              onPressed: () => context.go('/auth/credentials'),
              child: Text('auth.start.button'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
