// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

// Project imports:
import '../../../core/core.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key, required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.paddings.medium),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            onPressed: onStart,
            child: Text('auth.start.button'.tr()),
          ),
        ],
      ),
    );
  }
}
