import 'package:flutter/material.dart';

import '../state/products_state.dart';
//import 'package:injectable/injectable.dart';

//@Injectable()
class PaginationNumber extends ChangeNotifier {
  int currentPageIndex = 1; //EX: 1.2.3.4.5
  int totalPages = 1; //EX: 5
  int totalItems = 0; //EX: 100
  final int limitPage = 20; //Constant: limit = 20

  updatePageIndex(int newPageIndex) {
    currentPageIndex = newPageIndex;
    notifyListeners();
  }

  int getSkipValue() =>
      (currentPageIndex - 1) * limitPage; //EX: 0 , 20 , 40 , 60 , 80 , 100
  updateTotalPages(int newTotalPages) => totalPages = newTotalPages;
  updateTotalItems(int newTotalItems) => totalItems = newTotalItems;
}

//@Injectable()
class ProductsStateNotifier extends ChangeNotifier {
  ProductsState state = ProductsState.loading();

  updateState(ProductsState newState) {
    state = newState;
    notifyListeners();
  }
}
