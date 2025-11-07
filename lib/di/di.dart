import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wall_e/api/dio_client.dart';
import 'package:wall_e/data/datasources/authentication_remote_data_source.dart';
import 'package:wall_e/data/repository/authentication_repository_impl.dart';
import 'package:wall_e/login/bloc/login_bloc.dart';

import '../domain/repository/authentication_repository.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  sl.registerFactory(() => LoginBloc(authenticationRepository: sl()));
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(remoteSource: sl()),
  );
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(
      dioClient: sl(),
      firebaseAuth: FirebaseAuth.instance,
      googleSignIn: GoogleSignIn.instance
    ),
  );
  sl.registerLazySingleton(() => DioClient());
}
