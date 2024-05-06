// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import '../../core/core.dart';

// Project imports:

part 'provider.g.dart';

@riverpod
class SettingsState extends _$SettingsState {
  @override
  AsyncValue<Settings?> build() {
    final userId = ref.read(userStateProvider).value?.id;
    if (userId == null) {
      ref.read(loggerProvider).e('User not found');
      return const AsyncValue.data(null);
    }
    getSettings();
    return state;
  }

  void createSettings() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final userId = ref.read(userStateProvider).value!.id;
      final settings = Settings(
        id: const Uuid().v4(),
        userId: userId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final response = await ref
          .read(supabaseProvider)
          .from('Settings')
          .insert(settings.toJson())
          .select();
      if (response.isEmpty) {
        ref.read(loggerProvider).e('Error creating settings');
        return null;
      }
      return Settings.fromJson(response.first);
    });
  }

  void getSettings() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final userId = ref.read(userStateProvider).value!.id;
      final response = await ref
          .read(supabaseProvider)
          .from('Settings')
          .select()
          .eq('user_id', userId);
      if (response.isEmpty) {
        ref.read(loggerProvider).e('Error fetching settings');
        return null;
      }
      return Settings.fromJson(response.first);
    });
  }

  void updateSettings(Settings updatedSettings) async {
    // state = const AsyncValue.loading();
    final userId = ref.read(userStateProvider).value!.id;
    state = await AsyncValue.guard(() async {
      final response = await ref
          .read(supabaseProvider)
          .from('Settings')
          .update(updatedSettings.toJson())
          .eq('user_id', userId)
          .select();
      if (response.isEmpty) {
        ref.read(loggerProvider).e('Error updating settings');
        return null;
      }
      return Settings.fromJson(response.first);
    });
  }

  void deleteSettings() async {
    state = const AsyncValue.loading();
    final userId = ref.read(userStateProvider).value!.id;
    state = await AsyncValue.guard(() async {
      final response = await ref
          .read(supabaseProvider)
          .from('Settings')
          .delete()
          .eq('user_id', userId)
          .select();
      if (response.isEmpty) {
        ref.read(loggerProvider).e('Error deleting settings');
        return state.value;
      }
      return null;
    });
  }

  void clearSettings() async {
    state = const AsyncValue.data(null);
  }
}
