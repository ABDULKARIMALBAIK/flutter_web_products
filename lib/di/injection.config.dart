// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// // **************************************************************************
// // InjectableConfigGenerator
// // **************************************************************************
//
// import 'package:get_it/get_it.dart' as _i1;
// import 'package:injectable/injectable.dart' as _i2;
//
// import '../notifier/cart_notifier.dart' as _i3;
// import '../notifier/products_notifier.dart' as _i10;
// import '../repository/login_repository.dart' as _i8;
// import '../repository/products_repository.dart' as _i11;
// import '../repository/register_repository.dart' as _i13;
// import '../service/dio_service.dart' as _i5;
// import '../service/encryptor_service.dart' as _i6;
// import '../service/storage_service.dart' as _i15;
// import '../view_model/cart_view_model.dart' as _i4;
// import '../view_model/home_view_model.dart' as _i7;
// import '../view_model/login_view_model.dart' as _i9;
// import '../view_model/products_view_model.dart' as _i12;
// import '../view_model/register_view_model.dart'
//     as _i14; // ignore_for_file: unnecessary_lambdas
//
// // ignore_for_file: lines_longer_than_80_chars
// /// initializes the registration of provided dependencies inside of [GetIt]
// _i1.GetIt $initGetIt(_i1.GetIt get,
//     {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
//   final gh = _i2.GetItHelper(get, environment, environmentFilter);
//   gh.factory<_i3.CartStateProducts>(() => _i3.CartStateProducts());
//   gh.factory<_i3.CartTotalValueNotifier>(() => _i3.CartTotalValueNotifier());
//   gh.factory<_i4.CartViewModel>(() => _i4.CartViewModel());
//   gh.singleton<_i5.DioService>(_i5.DioService());
//   gh.singleton<_i6.EncryptorService>(_i6.EncryptorService());
//   gh.factory<_i7.HomeViewModel>(() => _i7.HomeViewModel());
//   gh.factory<_i8.LoginRepository>(() => _i8.LoginRepository());
//   gh.factory<_i9.LoginViewModel>(() => _i9.LoginViewModel());
//   gh.factory<_i10.PaginationNumber>(() => _i10.PaginationNumber());
//   gh.factory<_i11.ProductsRepository>(() => _i11.ProductsRepository());
//   gh.factory<_i10.ProductsStateNotifier>(() => _i10.ProductsStateNotifier());
//   gh.factory<_i12.ProductsViewModel>(() => _i12.ProductsViewModel());
//   gh.factory<_i13.RegisterRepository>(() => _i13.RegisterRepository());
//   gh.factory<_i14.RegisterViewModel>(() => _i14.RegisterViewModel());
//   gh.singleton<_i15.StorageService>(_i15.StorageService());
//   return get;
// }
