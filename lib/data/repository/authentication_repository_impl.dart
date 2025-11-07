import 'package:firebase_auth/firebase_auth.dart';
import 'package:wall_e/utils/api_status.dart';

import '../../domain/repository/authentication_repository.dart';
import '../datasources/authentication_remote_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl({required this.remoteSource});

  final AuthenticationRemoteDataSource remoteSource;

  @override
  Future<ApiStatus> logIn({
    required String email,
    required String password,
  }) async {
    return remoteSource.login(email: email, password: password);
  }

  @override
  Future<User?> googleLogIn() async {
    return remoteSource.googleLogin();
  }
}
