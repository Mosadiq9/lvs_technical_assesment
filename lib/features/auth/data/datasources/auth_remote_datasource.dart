import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/config/environment.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithGoogle();
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Stream<UserModel?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final fb.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize(
        serverClientId: Environment.googleServerClientId,
      );

      final googleUser = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final fb.OAuthCredential credential = fb.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final fb.UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);
      final fb.User? user = userCredential.user;

      if (user == null) {
        throw AuthException('Failed to sign in with Google.');
      }

      return UserModel.fromFirebaseUser(user);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user != null) {
        return UserModel.fromFirebaseUser(user);
      }
      return null;
    });
  }
}
