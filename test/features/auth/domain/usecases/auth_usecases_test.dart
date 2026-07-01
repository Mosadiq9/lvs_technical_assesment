import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:alive_app/features/auth/domain/entities/user_entity.dart';
import 'package:alive_app/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:alive_app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:alive_app/features/auth/domain/usecases/get_current_user_usecase.dart';

import '../../../../mocks/mock_generators.mocks.dart';

void main() {
  late MockAuthRepository mockRepository;
  late SignInWithGoogleUseCase signInUseCase;
  late SignOutUseCase signOutUseCase;
  late GetCurrentUserUseCase getCurrentUserUseCase;

  setUp(() {
    mockRepository = MockAuthRepository();
    signInUseCase = SignInWithGoogleUseCase(mockRepository);
    signOutUseCase = SignOutUseCase(mockRepository);
    getCurrentUserUseCase = GetCurrentUserUseCase(mockRepository);
  });

  const tUser = UserEntity(id: '1', email: 'test@test.com');

  test('SignInWithGoogleUseCase delegates to repository', () async {
    when(mockRepository.signInWithGoogle())
        .thenAnswer((_) async => const Right(tUser));

    final result = await signInUseCase();

    expect(result, const Right(tUser));
    verify(mockRepository.signInWithGoogle()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('SignOutUseCase delegates to repository', () async {
    when(mockRepository.signOut())
        .thenAnswer((_) async => const Right(null));

    final result = await signOutUseCase();

    expect(result, const Right(null));
    verify(mockRepository.signOut()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('GetCurrentUserUseCase delegates to repository', () async {
    when(mockRepository.getCurrentUser())
        .thenAnswer((_) async => const Right(tUser));

    final result = await getCurrentUserUseCase();

    expect(result, const Right(tUser));
    verify(mockRepository.getCurrentUser()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
