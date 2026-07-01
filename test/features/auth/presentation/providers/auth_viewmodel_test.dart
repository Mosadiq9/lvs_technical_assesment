import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:alive_app/core/errors/failures.dart';
import 'package:alive_app/features/auth/domain/entities/user_entity.dart';
import 'package:alive_app/features/auth/presentation/providers/auth_state.dart';
import 'package:alive_app/features/auth/presentation/providers/auth_viewmodel.dart';

import '../../../../mocks/mock_generators.mocks.dart';

void main() {
  late MockSignInWithGoogleUseCase mockSignInUseCase;
  late MockSignOutUseCase mockSignOutUseCase;
  late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;
  late AuthViewModel viewModel;

  setUp(() {
    mockSignInUseCase = MockSignInWithGoogleUseCase();
    mockSignOutUseCase = MockSignOutUseCase();
    mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
    
    viewModel = AuthViewModel(
      signInWithGoogleUseCase: mockSignInUseCase,
      signOutUseCase: mockSignOutUseCase,
      getCurrentUserUseCase: mockGetCurrentUserUseCase,
    );
  });

  const tUser = UserEntity(id: '1', email: 'test@test.com');

  test('initial state is AuthState.initial()', () {
    expect(viewModel.state, equals(const AuthState.initial()));
  });

  group('signInWithGoogle', () {
    test('emits loading then authenticated on success', () async {
      when(mockSignInUseCase.call()).thenAnswer((_) async => const Right(tUser));

      final expectedStates = [
        const AuthState.loading(),
        const AuthState.authenticated(tUser),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      await viewModel.signInWithGoogle();
    });

    test('emits loading then error on failure', () async {
      when(mockSignInUseCase.call()).thenAnswer((_) async => const Left(AuthFailure('error')));

      final expectedStates = [
        const AuthState.loading(),
        const AuthState.error('error'),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      await viewModel.signInWithGoogle();
    });
  });

  group('signOut', () {
    test('emits loading then unauthenticated on success', () async {
      when(mockSignOutUseCase.call()).thenAnswer((_) async => const Right(null));

      final expectedStates = [
        const AuthState.loading(),
        const AuthState.unauthenticated(),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      await viewModel.signOut();
    });

    test('emits loading then error on failure', () async {
      when(mockSignOutUseCase.call()).thenAnswer((_) async => const Left(AuthFailure('error')));

      final expectedStates = [
        const AuthState.loading(),
        const AuthState.error('error'),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      await viewModel.signOut();
    });
  });

  group('checkCurrentUser', () {
    test('emits loading then authenticated when user exists', () async {
      when(mockGetCurrentUserUseCase.call()).thenAnswer((_) async => const Right(tUser));

      final expectedStates = [
        const AuthState.loading(),
        const AuthState.authenticated(tUser),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      await viewModel.checkCurrentUser();
    });

    test('emits loading then unauthenticated when user is null', () async {
      when(mockGetCurrentUserUseCase.call()).thenAnswer((_) async => const Right(null));

      final expectedStates = [
        const AuthState.loading(),
        const AuthState.unauthenticated(),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      await viewModel.checkCurrentUser();
    });

    test('emits loading then unauthenticated on failure', () async {
      when(mockGetCurrentUserUseCase.call()).thenAnswer((_) async => const Left(ServerFailure('error')));

      final expectedStates = [
        const AuthState.loading(),
        const AuthState.unauthenticated(),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      await viewModel.checkCurrentUser();
    });
  });
}
