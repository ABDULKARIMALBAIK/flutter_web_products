import 'package:Products/model/products_model.dart';
import 'package:Products/service/storage_service.dart';
import 'package:Products/state/products_state.dart';
import 'package:Products/utils/constants.dart';
import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
// import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:razorpay_web/razorpay_web.dart';

import '../notifier/cart_notifier.dart';
import '../service/encryptor_service.dart';
import '../service/handler/exception_handler.dart';
import '../utils/resources_path.dart';
import '../widgets/custom_dialog/custom_snack_bar.dart';
import '../widgets/custom_dialog/top_snack_bar.dart';

// @Injectable()
class CartViewModel {
  late EncryptorService encryptor;
  late StorageService storageService;

  late CartTotalValueNotifier cartTotalValueNotifier;
  late CartStateProducts cartStateProducts;

  late ScrollController scrollController;

  List<Product> products = [];

  CartViewModel() {
    // encryptor = GetIt.I.get<EncryptorService>();
    encryptor = DataHelper.encryptorService;
    // storageService = GetIt.I.get<StorageService>();
    storageService = DataHelper.storageService;

    // cartTotalValueNotifier = GetIt.I.get<CartTotalValueNotifier>();
    cartTotalValueNotifier = CartTotalValueNotifier();
    // cartStateProducts = GetIt.I.get<CartStateProducts>();
    cartStateProducts = CartStateProducts();

    scrollController = ScrollController();
  }

  Future<void> allProducts() async {
    try {
      //Fetch Data
      final List<Product> currentProducts =
          await storageService.productStorage.allProducts();

      if (currentProducts.isEmpty) {
        Future.delayed(const Duration(seconds: 10));
        cartStateProducts.updateState(ProductsState.noData());
      } else {
        Future.delayed(const Duration(seconds: 10));
        products = currentProducts;
        cartStateProducts.updateState(ProductsState.success(currentProducts));
      }
    } catch (e) {
      ErrorModel errorModel =
          ExceptionHandler().handle(e, message404: 'Account is not exists');
      cartStateProducts.updateState(
          ProductsState.error(errorModel.message, errorModel.code));
    }
  }

  Future<void> updateQuantityProduct(Product product) async {
    await storageService.productStorage.updateProduct(product);
  }

  double calculateTotalPrice() {
    final String totalPrice = products
        .map<double>(
            (cart) => double.parse(cart.price.toString()) * cart.quantity)
        .reduce((value, element) => value + element)
        .toStringAsFixed(2);
    return double.parse(totalPrice);
  }

  void playDragProductsSound() {
    final playerDragProduct = AudioPlayer();
    playerDragProduct.setAsset(ResourcesPath.payProducts);
    playerDragProduct.setVolume(1);
    // playerDragProduct.setPitch(1);
    playerDragProduct.play();
  }

  void payProducts(BuildContext context) {
    //Run sound effect
    playDragProductsSound();

    //Run Razorpay Method
    final _razorpay = Razorpay();
    _razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) =>
            _handlePaymentSuccess(response, context));
    _razorpay.on(
        Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) =>
            _handlePaymentError(response, context));
    _razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) =>
            _handleExternalWallet(response, context));
    var options = {
      'key': 'rzp_test_3x4FbRpZeYzRUp', //Test Key
      'amount': cartTotalValueNotifier.totalValue,
      'name': 'ABDULKARIM Flutter Developer',
      'description': 'Buy Laptops , Keyboards , Mouses , IPhone',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(
      PaymentSuccessResponse response, BuildContext context) async {
    debugPrint('pay Success');
    debugPrint('pay Success paymentId: ${response.paymentId}');
    debugPrint('pay Success orderId: ${response.orderId}');
    debugPrint('pay Success signature: ${response.signature}');

    //Clear products from database
    storageService.productStorage.clear();

    //Clear Products from View Model
    products.clear();

    //Clear total value
    cartTotalValueNotifier.updateTotalValue(0);

    //Show Custom Dialog
    showTopSnackBar(
      context,
      const CustomSnackBar.success(
        message: "You Payment is sent successfully , Thank you",
      ),
    );

    //Pop The Page
    await Future.delayed(const Duration(milliseconds: 3000));
    GoRouter.of(context).pop();
  }

  void _handlePaymentError(
      PaymentFailureResponse response, BuildContext context) {
    debugPrint('pay Error');
    debugPrint('pay Error message: ${response.message}');
    debugPrint('pay Error code: ${response.code}');

    showTopSnackBar(
      context,
      const CustomSnackBar.error(
        message: "Payment processing cancelled by user",
      ),
    );
  }

  void _handleExternalWallet(
      ExternalWalletResponse response, BuildContext context) {
    debugPrint('pay wallet');
    debugPrint('pay wallet walletName: ${response.walletName}');

    showTopSnackBar(
      context,
      const CustomSnackBar.info(
        message: "You are using external wallet",
      ),
    );
  }
}
