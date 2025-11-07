import 'package:wall_e/api/dio_client.dart';
import 'package:wall_e/utils/api_status.dart';

abstract class AuthenticationRemoteDataSource {
  Future<ApiStatus> login({required String email, required String password});
}

class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource{
  final DioClient dioClient;

  AuthenticationRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<ApiStatus> login({required String email, required String password}) async {
    try{
      return Future.delayed(const Duration(seconds: 10)).then((value) => ApiStatus.success);
      //dioClient.post("path",queryParameters: {"email":email,"password": password});
    }catch(e){
      return ApiStatus.failure;
    }
  }
}
