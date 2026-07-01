import 'dart:async';
import 'package:alive_app/core/errors/exceptions.dart';
import 'package:alive_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:alive_app/features/auth/data/models/user_model.dart';

class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  UserModel? _currentUser;
  final _authStateController = StreamController<UserModel?>.broadcast();

  @override
  Future<UserModel> signInWithGoogle() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = const UserModel(
      id: 'test_user_123',
      email: 'test@example.com',
      displayName: 'Test User',
    );
    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _currentUser = null;
    _authStateController.add(null);
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return _currentUser;
  }

  @override
  Stream<UserModel?> get authStateChanges => _authStateController.stream;
}

class FailingFakeAuthDataSource extends FakeAuthRemoteDataSource {
  @override
  Future<UserModel> signInWithGoogle() async {
    await Future.delayed(const Duration(milliseconds: 500));
    throw AuthException('Google Sign-In aborted by user.');
  }
}
