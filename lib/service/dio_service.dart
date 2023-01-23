import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
import '../utils/urls.dart';

// @Singleton()
class DioService {
  late final Dio _dio;

  DioService() {
    final BaseOptions options = BaseOptions(
        baseUrl: ConstUrls.baseUrl,
        sendTimeout: 20000,
        connectTimeout: 20000,
        receiveTimeout: 40000,
        contentType: "application/json");
    _dio = Dio(options);
  }

  Dio get dioClient => _dio;
}
