import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:injectable/injectable.dart';

import '../service/dio_service.dart';
import '../utils/constants.dart';
import '../utils/urls.dart';

// @Injectable()
class RegisterRepository {
  RegisterRepository() {
    // dioService = GetIt.I.get<DioService>();
    dioService = DataHelper.dioService;
  }

  late DioService dioService;

  Future<Response> registerUser(String username, String password) {
    return dioService.dioClient.post(
      ConstUrls.registerUrl,
      data: {
        "username": username,
        "password": password,
      },
    );
  }
}
