import 'package:firebase_auth/firebase_auth.dart';
import 'package:wall_e/utils/api_status.dart';

abstract class AuthenticationRepository {
  Future<ApiStatus> logIn({required String email, required String password});

  Future<User?> googleLogIn();
}
