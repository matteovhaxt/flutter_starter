import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'provider.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  AsyncValue<Session?> build() =>
      AsyncValue.data(Supabase.instance.client.auth.currentSession);

  void signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw UnimplementedError();
      } else {
        return response.session;
      }
    });
  }

  void signUpWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw UnimplementedError();
      } else {
        return response.session;
      }
    });
  }

  void signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client.auth.signOut();
      return null;
    });
  }
}
