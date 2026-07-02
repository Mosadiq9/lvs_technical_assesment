import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import 'auth_state.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthViewModel({
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
    required SignOutUseCase signOutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  }) : _signInWithGoogleUseCase = signInWithGoogleUseCase,
       _signOutUseCase = signOutUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       super(const AuthState.initial());

  Future<void> checkCurrentUser() async {
    state = const AuthState.loading();
    final result = await _getCurrentUserUseCase();
    result.fold((failure) => state = const AuthState.unauthenticated(), (user) {
      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = const AuthState.unauthenticated();
      }
    });
  }

  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    final result = await _signInWithGoogleUseCase();
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> signOut() async {
    state = const AuthState.loading();
    final result = await _signOutUseCase();
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (_) => state = const AuthState.unauthenticated(),
    );
  }
}
