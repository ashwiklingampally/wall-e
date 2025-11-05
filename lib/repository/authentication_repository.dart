import 'dart:async';

import 'package:wall_e/utils/api_status.dart';

class AuthenticationRepository {
  Future<ApiStatus> logIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 5));
    return ApiStatus.success;
  }
}
