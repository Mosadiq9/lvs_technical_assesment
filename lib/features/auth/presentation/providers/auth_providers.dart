import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared/providers/shared_providers.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import 'auth_state.dart';
import 'auth_viewmodel.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthRemoteDataSourceImpl(firebaseAuth);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource);
});

final signInWithGoogleUseCaseProvider = Provider<SignInWithGoogleUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignInWithGoogleUseCase(repository);
});

final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignOutUseCase(repository);
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GetCurrentUserUseCase(repository);
});

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    signInWithGoogleUseCase: ref.watch(signInWithGoogleUseCaseProvider),
    signOutUseCase: ref.watch(signOutUseCaseProvider),
    getCurrentUserUseCase: ref.watch(getCurrentUserUseCaseProvider),
  );
});
