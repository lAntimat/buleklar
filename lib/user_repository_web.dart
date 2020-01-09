import 'package:buleklar/IUserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
class UserRepositoryWeb implements IUserRepository {


  @override
  Future<FirebaseUser> signInWithGoogle() {

  }

  @override
  Future<String> getUser() {

  }

  @override
  Future<bool> isSignedIn() {
    return Future.value(true);
  }

  @override
  Future<Function> signOut() {

  }

  @override
  Future<Function> signUp({String email, String password}) {

  }

  @override
  Future<Function> signInWithCredentials(String email, String password) {

  }
}