import 'dart:async';

import 'package:Products/model/products_model.dart';
import 'package:Products/repository/products_repository.dart';
import 'package:Products/service/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
// import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';

import '../notifier/products_notifier.dart';
import '../service/handler/exception_handler.dart';
import '../state/products_state.dart';
import '../utils/constants.dart';
import '../utils/resources_path.dart';
import '../utils/router/routers.dart';

// @Injectable()
class ProductsViewModel {
  late ScrollController scrollController;

  late PaginationNumber paginationNumber;
  late ProductsStateNotifier productsState;
  late List<Product> products;

  late ProductsRepository repository;
  late StorageService storageService;

  bool firstLoadTime = true;

  ProductsViewModel() {
    products = [];

    scrollController = ScrollController();

    // paginationNumber = GetIt.I.get<PaginationNumber>();
    // productsState = GetIt.I.get<ProductsStateNotifier>();
    // repository = GetIt.I.get<ProductsRepository>();
    // storageService = GetIt.I.get<StorageService>();

    paginationNumber = PaginationNumber();
    productsState = ProductsStateNotifier();
    repository = ProductsRepository();
    storageService = DataHelper.storageService;
  }

  //Fetch Data when:
  // 1- load first time
  // 2- refresh data
  // fetchAllProducts() async {
  //
  //   //Send Idle
  //   // allProductsStream.add(ProductsState.idle());
  //   // Future.delayed(const Duration(seconds: 5));
  //
  //
  //   if(products.isNotEmpty){
  //     //Send Loading
  //     // allProductsStream.add(ProductsState.loading());
  //     // Future.delayed(const Duration(seconds: 14));
  //
  //     //First Page
  //     allProductsStream.add(ProductsState.success(products.sublist(0 , 19)));
  //   }
  //   else {
  //     try{
  //       //Fetch Data
  //       final Response response = await repository.getProducts(
  //           paginationNumber.limitPage,
  //           0);
  //
  //       if(response.statusCode == 200 || response.statusCode == 201){
  //
  //         //Send Loading
  //         // allProductsStream.add(ProductsState.loading());
  //         // Future.delayed(const Duration(seconds: 5));
  //
  //         //Mapping
  //         ProductsModel productModel = ProductsModel.fromJson(response.data);
  //
  //         if(productModel.products.isEmpty){
  //           //Send No Data
  //           allProductsStream.add(ProductsState.noData());
  //         }
  //         else {
  //           Future.delayed(const Duration(seconds: 5));
  //
  //           paginationNumber.updateTotalItems(productModel.total);
  //           paginationNumber.updateTotalPages((productModel.total/paginationNumber.limitPage).ceil());  //result: 5.4 = 6 pages
  //
  //           products.clear();
  //           products = productModel.products;
  //
  //           allProductsStream.add(ProductsState.success(products));
  //         }
  //
  //       }
  //       else {
  //         allProductsStream.add(ProductsState.error(response.statusMessage ?? '', response.statusCode.toString()));
  //       }
  //     }
  //     catch(e){
  //
  //       ErrorModel errorModel = ExceptionHandler().handle(e , message404: 'Account is not exists');
  //       allProductsStream.add(ProductsState.error(errorModel.message, errorModel.code));
  //
  //     }
  //
  //   }
  //
  // }

  fetchNextPageProducts() async {
    //Send Idle (Already sent)
    // paginationProductsStream.add(ProductsState.idle());
    // Future.delayed(const Duration(seconds: 5));

    if (products.isEmpty) {
      try {
        //Fetch Data
        final Response response =
            await repository.getProducts(paginationNumber.limitPage, 0);

        if (response.statusCode == 200 || response.statusCode == 201) {
          //Send Loading
          productsState.updateState(ProductsState.loading());
          Future.delayed(const Duration(seconds: 27));

          //Mapping
          ProductsModel productModel = ProductsModel.fromJson(response.data);
          if (productModel.products.isEmpty) {
            //Send No Data
            //paginationProductsStream.add(ProductsState.noData());

            productsState.updateState(ProductsState.noData());
          } else {
            Future.delayed(const Duration(seconds: 5));
            paginationNumber.updateTotalItems(productModel.total);
            paginationNumber.updateTotalPages(
                (productModel.total / paginationNumber.limitPage)
                    .ceil()); //result: 5.4 = 6 pages
            // products.clear();
            products = productModel.products;
            //paginationProductsStream.add(ProductsState.success(products));

            productsState.updateState(ProductsState.success(products));
          }
        } else {
          //paginationProductsStream.add(ProductsState.error(response.statusMessage ?? '', response.statusCode.toString()));
          productsState.updateState(ProductsState.error(
              response.statusMessage ?? '', response.statusCode.toString()));
        }
      } catch (e) {
        ErrorModel errorModel =
            ExceptionHandler().handle(e, message404: 'Account is not exists');
        //paginationProductsStream.add(ProductsState.error(errorModel.message, errorModel.code));
        productsState.updateState(
            ProductsState.error(errorModel.message, errorModel.code));
      }
    } else if (products.length >=
        (paginationNumber.currentPageIndex * paginationNumber.limitPage) - 1) {
      //Send Loading
      // allProductsStream.add(ProductsState.loading());
      // Future.delayed(const Duration(seconds: 14));

      //First Page
      // paginationProductsStream.add(
      //     ProductsState.success(products.sublist(
      //         paginationNumber.getSkipValue(),
      //         (paginationNumber.currentPageIndex * paginationNumber.limitPage) - 1  //This work fine with duplicates skip values like: total = 100 , otherwise: total = 106 not working
      //     ))
      // );
      productsState.updateState(ProductsState.success(products.sublist(
          paginationNumber.getSkipValue(),
          (paginationNumber.currentPageIndex * paginationNumber.limitPage) -
              1 //This work fine with duplicates skip values like: total = 100 , otherwise: total = 106 not working
          )));
    } else {
      try {
        //Fetch Data
        final Response response = await repository.getProducts(
            paginationNumber.limitPage, paginationNumber.getSkipValue());

        if (response.statusCode == 200 || response.statusCode == 201) {
          //Send Loading
          productsState.updateState(ProductsState.loading());
          Future.delayed(const Duration(seconds: 14));

          //Mapping
          ProductsModel productModel = ProductsModel.fromJson(response.data);

          if (productModel.products.isEmpty) {
            //Send No Data
            productsState.updateState(ProductsState.noData());
          } else {
            Future.delayed(const Duration(seconds: 5));

            paginationNumber.updateTotalItems(productModel.total);
            paginationNumber.updateTotalPages(
                (productModel.total / paginationNumber.limitPage)
                    .ceil()); //result: 5.4 = 6 pages

            products.addAll(productModel.products);

            productsState
                .updateState(ProductsState.success(productModel.products));
          }
        } else {
          productsState.updateState(ProductsState.error(
              response.statusMessage ?? '', response.statusCode.toString()));
        }
      } catch (e) {
        ErrorModel errorModel =
            ExceptionHandler().handle(e, message404: 'Account is not exists');
        productsState.updateState(
            ProductsState.error(errorModel.message, errorModel.code));
      }
    }
  }

  Future<int> countProductStorage() async {
    final int count = await storageService.productStorage.countProducts();
    return count;
  }

  Future<void> saveProductStorage(Product product) async {
    await storageService.productStorage.saveProduct(product);
  }

  void playDragProductsSound() {
    final playerDragProduct = AudioPlayer();
    playerDragProduct.setAsset(ResourcesPath.dragProduct);
    playerDragProduct.setVolume(1);
    // playerDragProduct.setPitch(1);
    playerDragProduct.play();
  }

  void playAddProductsSound() {
    final playerAddProduct = AudioPlayer();
    playerAddProduct.setAsset(ResourcesPath.addProduct);
    playerAddProduct.setVolume(1);
    // playerAddProduct.setPitch(1);
    playerAddProduct.play();
  }

  void goCart(BuildContext context) =>
      GoRouter.of(context).pushNamed(Routers.cartName);
}
