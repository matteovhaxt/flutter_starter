// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

// Project imports:
import '../../../core/core.dart';
import '../auth.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.profile.name_is_required'.tr();
    }
    return null;
  }

  String? _validateBirthdate(String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.profile.birthdate_is_required'.tr();
    }
    return null;
  }

  Future<DateTime?> _showBirthdatePicker(BuildContext context) async {
    return await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final birthdateController = useTextEditingController();
    final userState = ref.read(userStateProvider);
    if (userState.hasError) {
      context.showSnackBar(userState.error.toString());
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddings.medium),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              autofocus: true,
              validator: _validateName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'auth.profile.name'.tr(),
              ),
            ),
            TextFormField(
              controller: birthdateController,
              onTapAlwaysCalled: true,
              onTap: () async {
                final date = await _showBirthdatePicker(context);
                if (date != null) {
                  final formatted = DateFormat("yyyy-MM-dd").format(date);
                  birthdateController.text = formatted;
                }
              },
              validator: _validateBirthdate,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'auth.profile.birthdate'.tr(),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(LucideIcons.userPlus),
                  label: Text('auth.profile.signup'.tr()),
                  onPressed: () {
                    ref.read(userStateProvider.notifier).createUser(
                          nameController.text,
                          DateTime.parse(birthdateController.text),
                        );
                  },
                ),
                TextButton.icon(
                  icon: const Icon(LucideIcons.logOut),
                  label: Text('auth.profile.signout'.tr()),
                  onPressed: () {
                    ref.read(authStateProvider.notifier).signOut();
                  },
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
