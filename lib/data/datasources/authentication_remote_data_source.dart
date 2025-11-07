import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wall_e/api/dio_client.dart';
import 'package:wall_e/utils/api_status.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:meta/meta.dart';

abstract class AuthenticationRemoteDataSource {
  Future<ApiStatus> login({required String email, required String password});

  Future<User?> googleLogin();
}

class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  final DioClient dioClient;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthenticationRemoteDataSourceImpl({
    required this.dioClient,
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Future<ApiStatus> login({
    required String email,
    required String password,
  }) async {
    try {
      return Future.delayed(
        const Duration(seconds: 10),
      ).then((value) => ApiStatus.success);
      //dioClient.post("path",queryParameters: {"email":email,"password": password});
    } catch (e) {
      return ApiStatus.failure;
    }
  }

  @override
  Future<User?> googleLogin() async {
      try {
        late final AuthCredential credential;
        if (kIsWeb) {
          final googleProvider = firebase_auth.GoogleAuthProvider();
          final userCredential = await firebaseAuth.signInWithPopup(
            googleProvider,
          );
          credential = userCredential.credential!;
        } else {
          final googleUser = await googleSignIn.authenticate(scopeHint: ["email"]);
          final googleAuth =  googleUser.authentication;
          credential = firebase_auth.GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
          );
        }

        await firebaseAuth.signInWithCredential(credential);
      } on firebase_auth.FirebaseAuthException catch (e) {
        throw e.code;
      } catch (_) {
        throw  firebase_auth.FirebaseAuthException(
          code: 'firebase_auth/unknown',
          message: 'An unknown error occurred.',
        );
      }
      return null;
    }
}