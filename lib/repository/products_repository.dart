import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:injectable/injectable.dart';

import '../service/dio_service.dart';
import '../utils/constants.dart';
import '../utils/urls.dart';

// @Injectable()
class ProductsRepository {
  ProductsRepository() {
    // dioService = GetIt.I.get<DioService>();
    dioService = DataHelper.dioService;
  }

  late DioService dioService;

  Future<Response> getProducts(int limit, int skip) {
    return dioService.dioClient.get(ConstUrls.productsAllUrl,
        queryParameters: {'limit': limit, 'skip': skip});
  }

  Future<Response> searchProducts(int limit, int skip, String searchText) {
    return dioService.dioClient.get(ConstUrls.productsSearchUrl,
        queryParameters: {'limit': limit, 'skip': skip, 'q': searchText});
  }
}
