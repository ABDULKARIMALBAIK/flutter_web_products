import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:injectable/injectable.dart';

import '../service/dio_service.dart';
import '../utils/constants.dart';
import '../utils/urls.dart';

// @Injectable()
class LoginRepository {
  LoginRepository() {
    // dioService = GetIt.I.get<DioService>();
    dioService = DataHelper.dioService;
  }

  late DioService dioService;

  Future<Response> loginUser(String username, String password) {
    return dioService.dioClient.post(ConstUrls.loginUrl,
        data: {
          "username": username,
          "password": password,
        },
        options: Options(
          headers: {
            'content-Type': 'application/json',
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoia21pbmNoZWxsZSIsImVtYWlsIjoia21pbmNoZWxsZUBxcS5jb20iLCJmaXJzdE5hbWUiOiJKZWFubmUiLCJsYXN0TmFtZSI6IkhhbHZvcnNvbiIsImdlbmRlciI6ImZlbWFsZSIsImltYWdlIjoiaHR0cHM6Ly9yb2JvaGFzaC5vcmcvYXV0cXVpYXV0LnBuZz9zaXplPTUweDUwJnNldD1zZXQxIiwiaWF0IjoxNjM1NzczOTYyLCJleHAiOjE2MzU3Nzc1NjJ9.n9PQX8w8ocKo0dMCw3g8bKhjB8Wo7f7IONFBDqfxKhs'
          },
          method: 'POST',
        ));
  }
}
