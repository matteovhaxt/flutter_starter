// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import '../core.dart';

part 'user.g.dart';

@riverpod
class UserState extends _$UserState {
  @override
  AsyncValue<User?> build() {
    final authId = ref.read(supabaseProvider).auth.currentSession?.user.id;
    if (authId == null) {
      ref.read(loggerProvider).e('Auth user not found');
      return const AsyncValue.data(null);
    }
    getUser(authId);
    return state;
  }

  void createUser(String name, DateTime birthDate) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = User(
        id: const Uuid().v4(),
        authId: ref.read(supabaseProvider).auth.currentSession!.user.id,
        name: name,
        birthDate: birthDate,
        email: ref.read(supabaseProvider).auth.currentSession!.user.email!,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final response = await ref
          .read(supabaseProvider)
          .from('User')
          .insert(user.toJson())
          .select();
      if (response.isEmpty) {
        ref.read(loggerProvider).e('Error creating user');
        return null;
      }
      return User.fromJson(response.first);
    });
  }

  void getUser(String authId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref
          .read(supabaseProvider)
          .from('User')
          .select()
          .eq('auth_id', authId);
      if (response.isEmpty) {
        ref.read(loggerProvider).e('Error fetching user');
        return null;
      }
      return User.fromJson(response.first);
    });
  }

  void updateUser(User updatedUser) async {
    state = const AsyncValue.loading();
    final authId = ref.read(supabaseProvider).auth.currentSession!.user.id;
    state = await AsyncValue.guard(() async {
      final response = await ref
          .read(supabaseProvider)
          .from('User')
          .update(updatedUser.toJson())
          .eq('auth_id', authId)
          .select();
      if (response.isEmpty) {
        ref.read(loggerProvider).e('Error updating user');
        return null;
      }
      return User.fromJson(response.first);
    });
  }

  void deleteUser() async {
    state = const AsyncValue.loading();
    final authId = ref.read(supabaseProvider).auth.currentSession!.user.id;
    state = await AsyncValue.guard(() async {
      final response = await ref
          .read(supabaseProvider)
          .from('User')
          .delete()
          .eq('auth_id', authId)
          .select();
      if (response.isEmpty) {
        ref.read(loggerProvider).e('Error deleting user');
        return null;
      }
      return null;
    });
  }

  void clearUser() async {
    state = const AsyncValue.data(null);
  }
}
