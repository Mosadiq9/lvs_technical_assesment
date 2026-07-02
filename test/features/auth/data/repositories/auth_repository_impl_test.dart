import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:alive_app/core/errors/exceptions.dart';
import 'package:alive_app/core/errors/failures.dart';
import 'package:alive_app/features/auth/data/models/user_model.dart';
import 'package:alive_app/features/auth/data/repositories/auth_repository_impl.dart';

import '../../../../mocks/mock_generators.mocks.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource);
  });

  const tUserModel = UserModel(
    id: '123',
    email: 'test@test.com',
    displayName: 'Test',
  );

  final tUserEntity = tUserModel.toEntity();

  group('signInWithGoogle', () {
    test('should return Right(UserEntity) on success', () async {
      when(
        mockRemoteDataSource.signInWithGoogle(),
      ).thenAnswer((_) async => tUserModel);

      final result = await repository.signInWithGoogle();

      result.fold(
        (l) => fail('Expected Right'),
        (r) => expect(r, equals(tUserEntity)),
      );
      verify(mockRemoteDataSource.signInWithGoogle()).called(1);
    });

    test('should return Left(AuthFailure) on AuthException', () async {
      when(
        mockRemoteDataSource.signInWithGoogle(),
      ).thenThrow(AuthException('error message'));

      final result = await repository.signInWithGoogle();

      result.fold((l) {
        expect(l, isA<AuthFailure>());
        expect(l.message, 'error message');
      }, (r) => fail('Expected Left'));
    });

    test('should return Left(ServerFailure) on generic Exception', () async {
      when(
        mockRemoteDataSource.signInWithGoogle(),
      ).thenThrow(Exception('generic error'));

      final result = await repository.signInWithGoogle();

      result.fold((l) {
        expect(l, isA<ServerFailure>());
        expect(l.message, 'Exception: generic error');
      }, (r) => fail('Expected Left'));
    });
  });

  group('signOut', () {
    test('should return Right(null) on success', () async {
      when(
        mockRemoteDataSource.signOut(),
      ).thenAnswer((_) async => Future.value());

      final result = await repository.signOut();

      result.fold((l) => fail('Expected Right'), (r) {});
    });

    test('should return Left(AuthFailure) on AuthException', () async {
      when(
        mockRemoteDataSource.signOut(),
      ).thenThrow(AuthException('error message'));

      final result = await repository.signOut();

      result.fold((l) {
        expect(l, isA<AuthFailure>());
        expect(l.message, 'error message');
      }, (r) => fail('Expected Left'));
    });
  });

  group('getCurrentUser', () {
    test('should return Right(UserEntity) when user exists', () async {
      when(
        mockRemoteDataSource.getCurrentUser(),
      ).thenAnswer((_) async => tUserModel);

      final result = await repository.getCurrentUser();

      result.fold(
        (l) => fail('Expected Right'),
        (r) => expect(r, equals(tUserEntity)),
      );
    });

    test('should return Right(null) when no user exists', () async {
      when(mockRemoteDataSource.getCurrentUser()).thenAnswer((_) async => null);

      final result = await repository.getCurrentUser();

      result.fold((l) => fail('Expected Right'), (r) => expect(r, isNull));
    });

    test('should return Left(ServerFailure) on Exception', () async {
      when(mockRemoteDataSource.getCurrentUser()).thenThrow(Exception('error'));

      final result = await repository.getCurrentUser();

      result.fold((l) {
        expect(l, isA<ServerFailure>());
        expect(l.message, 'Exception: error');
      }, (r) => fail('Expected Left'));
    });
  });

  group('authStateChanges', () {
    test('should map UserModel stream to UserEntity stream', () {
      when(
        mockRemoteDataSource.authStateChanges,
      ).thenAnswer((_) => Stream.value(tUserModel));

      final result = repository.authStateChanges;

      expect(result, emits(tUserEntity));
    });
  });
}
