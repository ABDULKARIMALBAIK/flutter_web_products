import 'package:flutter/material.dart';

import '../state/products_state.dart';
// import 'package:injectable/injectable.dart';

// @Injectable()
class CartTotalValueNotifier extends ChangeNotifier {
  double totalValue = 0;

  updateTotalValue(double newValue) {
    totalValue = newValue;
    notifyListeners();
  }
}

// @Injectable()
class CartStateProducts extends ChangeNotifier {
  ProductsState state = ProductsState.loading();

  updateState(ProductsState newState) {
    state = newState;
    notifyListeners();
  }
}
