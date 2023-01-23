import '../model/products_model.dart';

class ProductsState {
  ProductsState();

  factory ProductsState.idle() = ProductsIdle;
  factory ProductsState.loading() = ProductsLoading;
  factory ProductsState.success(List<Product> products) = ProductsSuccess;
  factory ProductsState.error(String message, String code) = ProductsError;
  factory ProductsState.errorNullData() = ProductsErrorNullData;
  factory ProductsState.noData() = ProductsNoData;
}

class ProductsIdle extends ProductsState {
  ProductsIdle();
}

class ProductsLoading extends ProductsState {
  ProductsLoading();
}

class ProductsNoData extends ProductsState {
  ProductsNoData();
}

class ProductsError extends ProductsState {
  ProductsError(this.message, this.code);

  final String message, code;
}

class ProductsErrorNullData extends ProductsState {
  ProductsErrorNullData();
}

class ProductsSuccess extends ProductsState {
  ProductsSuccess(this.products);

  List<Product> products;
}
