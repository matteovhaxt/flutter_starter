// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../../core/core.dart';
import '../features.dart';

class SignupView extends HookConsumerWidget {
  const SignupView({super.key});

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'signup.name_is_required'.tr();
    }
    return null;
  }

  String? _validateBirthdate(String? value) {
    if (value == null || value.isEmpty) {
      return 'signup.birthdate_is_required'.tr();
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
    return Scaffold(
      body: Padding(
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
                  labelText: 'signup.name'.tr(),
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
                  labelText: 'signup.birthdate'.tr(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(userStateProvider.notifier).createUser(
                        nameController.text,
                        DateTime.parse(birthdateController.text),
                      );
                },
                child: Text('signup.signup'.tr()),
              ),
              TextButton(
                onPressed: () {
                  ref.read(authStateProvider.notifier).signOut();
                },
                child: Text('signup.signout'.tr()),
              )
            ].separated(
              const Gap(8),
            ),
          ),
        ),
      ),
    );
  }
}
