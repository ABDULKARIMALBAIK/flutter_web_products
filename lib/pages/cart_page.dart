import 'dart:math';

import 'package:Products/widgets/adaptive_widgets/adaptive_image.dart';
import 'package:Products/widgets/adaptive_widgets/adaptive_text.dart';
import 'package:Products/widgets/smooth_scroll/custom_scroll_behavior.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_style.dart';

import '../model/products_model.dart';
import '../notifier/cart_notifier.dart';
import '../state/products_state.dart';
import '../utils/localization/app_localizations.dart';
import '../utils/platform_detector.dart';
import '../utils/resources_path.dart';
import '../view_model/cart_view_model.dart';
import '../widgets/data_template.dart';

// ignore: must_be_immutable
class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key) {
    // viewModel = GetIt.I.get<CartViewModel>();
    viewModel = CartViewModel();

    Future.delayed(const Duration(milliseconds: 4000)).then((value) {
      viewModel.allProducts().then((value) {
        viewModel.cartTotalValueNotifier
            .updateTotalValue(viewModel.calculateTotalPrice());
      });
    });
  }

  late CartViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ChangeNotifierProvider<CartTotalValueNotifier>.value(
          value: viewModel.cartTotalValueNotifier,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //////////////////////// * Carts * ////////////////////////
                Expanded(
                  child: _cartsData(context),
                ),

                //////////////////////// * Total Value * ////////////////////////
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //////////////////////// * Total Value * ////////////////////////
                          Flexible(
                            child: Consumer<CartTotalValueNotifier>(
                              builder: (context, notifier, child) {
                                return Row(
                                  children: [
                                    AdaptiveText(
                                      text: AppLocalizations.of(context)!
                                          .translate('cart_pay_price_title'),
                                      headerText: "title Price of products",
                                      headerType: TextRendererStyle.header5,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      hint: "title Price of products",
                                      label: "title Price of products",
                                      value: "title Price of products",
                                    ),

                                    const SizedBox(
                                      width: 3,
                                    ),

                                    AnimatedFlipCounter(
                                        value: notifier.totalValue,
                                        fractionDigits: 2, // decimal precision
                                        suffix: "%",
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .primaryColor)),

                                    // AdaptiveText(
                                    //   text: notifier.totalValue.toString(),
                                    //   headerText:
                                    //   "Total Price of products",
                                    //   headerType: TextRendererStyle.header5,
                                    //   style: Theme.of(context)
                                    //       .textTheme
                                    //       .headline5!
                                    //       .copyWith(fontWeight: FontWeight.w400 , color: Theme.of(context).primaryColor),
                                    //   textAlign: TextAlign.start,
                                    //   maxLines: 1,
                                    //   hint:
                                    //   "Total Price of products",
                                    //   label:
                                    //   "Total Price of products",
                                    //   value:
                                    //   "Total Price of products",
                                    // )    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Use here incremental package
                                  ],
                                );
                              },
                            ),
                          ),

                          //////////////////////// * Buy Button * ////////////////////////
                          Flexible(
                            child: Semantics(
                              readOnly: true,
                              button: true,
                              label: 'Pay Products Button',
                              hint: 'Pay Products Button',
                              value: 'Pay Products Button',
                              child: SizedBox(
                                width: 200,
                                height: 80,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22)),
                                    padding: const EdgeInsets.all(18),
                                    elevation: 12,
                                    shadowColor: Theme.of(context).primaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('cart_pay_button'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                  ),
                                  onPressed: () {
                                    viewModel.payProducts(context);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _cartsData(BuildContext context) {
    return ChangeNotifierProvider<CartStateProducts>.value(
      value: viewModel.cartStateProducts,
      child: Consumer<CartStateProducts>(
        builder: (context, notifier, child) {
          // ignore: unnecessary_null_comparison
          if (notifier != null) {
            ProductsState productsState = notifier.state;

            //////////////////////// * Idle * ////////////////////////
            if (productsState is ProductsIdle) {
              //print('is Loading now');
              return DataTemplate().loading(context);
            }

            //////////////////////// * Loading * ////////////////////////
            if (productsState is ProductsLoading) {
              //print('is Loading now');
              return DataTemplate().loading(context);
            }

            //////////////////////// * NoData * ////////////////////////
            else if (productsState is ProductsNoData) {
              //print('is NoData now');
              return DataTemplate().noData(
                  context: context,
                  widthImage: 300,
                  heightImage: 300,
                  text: AppLocalizations.of(context)!.translate('cart_no_data'),
                  style: Theme.of(context).textTheme.headline6,
                  imageLinkAssets: ResourcesPath().noData);
            }

            //////////////////////// * Error * ////////////////////////
            else if (productsState is ProductsError) {
              //print('is Error now');

              //ProductsError error = productsState;
              return DataTemplate().error(
                  context: context,
                  widthImage: 300,
                  heightImage: 300,
                  text: AppLocalizations.of(context)!.translate('error'),
                  style: Theme.of(context).textTheme.headline6,
                  imageLinkAssets: ResourcesPath().error);
            }

            //////////////////////// * Success * ////////////////////////
            else if (productsState is ProductsSuccess) {
              //ProductsSuccess success = productsState;

              if (viewModel.products.isEmpty) {
                //print('is NoData of list now');
                return DataTemplate().noData(
                    context: context,
                    widthImage: 300,
                    heightImage: 300,
                    text:
                        AppLocalizations.of(context)!.translate('cart_no_data'),
                    style: Theme.of(context).textTheme.headline6,
                    imageLinkAssets: ResourcesPath().noData);
              } else {
                //print('data: ${data.length}');

                Future.delayed(const Duration(milliseconds: 2000));

                return
                    //Web for mobile (Android & IOS)
                    PlatformDetector().isWeb() &&
                            (Theme.of(context).platform == TargetPlatform.iOS ||
                                Theme.of(context).platform ==
                                    TargetPlatform.android)
                        ? _singleScrollChild(context)
                        :
                        //Web for Desktops (Windows-MacOS-Linux)
                        _desktopWebScroller(context);
              }
            }
            //////////////////////// * Another Option * ////////////////////////
            else {
              //print('Unknown state');
              return DataTemplate().error(
                  context: context,
                  widthImage: 300,
                  heightImage: 300,
                  text: AppLocalizations.of(context)!.translate('error'),
                  style: Theme.of(context).textTheme.headline6,
                  imageLinkAssets: ResourcesPath().error);
            }
          }
          //////////////////////// * State is NULL * ////////////////////////
          else {
            return DataTemplate().loading(context);
          }
        },
      ),
    );
  }

  _desktopWebScroller(BuildContext context) {
    return ImprovedScrolling(
        scrollController: viewModel.scrollController,
        mmbScrollConfig: const MMBScrollConfig(
          customScrollCursor: DefaultCustomScrollCursor(),
        ),
        keyboardScrollConfig: KeyboardScrollConfig(
          homeScrollDurationBuilder: (currentScrollOffset, minScrollOffset) {
            return const Duration(milliseconds: 100);
          },
          endScrollDurationBuilder: (currentScrollOffset, maxScrollOffset) {
            return const Duration(milliseconds: 2000);
          },
        ),
        customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
          scrollAmountMultiplier: 2.0,
        ),
        onScroll: (scrollOffset) {
          //print(Scroll offset: $scrollOffset',),
        },
        onMMBScrollStateChanged: (scrolling) {
          //print('Is scrolling: $scrolling',)
        },
        onMMBScrollCursorPositionUpdate: (localCursorOffset, scrollActivity) {
          //print('Cursor position: $localCursorOffset\n''Scroll activity: $scrollActivity',)
        },
        enableMMBScrolling: true,
        enableKeyboardScrolling: true,
        enableCustomMouseWheelScrolling: true,
        child: ScrollConfiguration(
          behavior: const CustomScrollBehavior(),
          child: _singleScrollChild(context),
        ));
  }

  _singleScrollChild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: ListView.builder(
        physics:
            //Web to Android or IOS OS
            PlatformDetector().isWeb() &&
                    (Theme.of(context).platform == TargetPlatform.windows ||
                        Theme.of(context).platform == TargetPlatform.linux ||
                        Theme.of(context).platform == TargetPlatform.macOS ||
                        Theme.of(context).platform == TargetPlatform.fuchsia)
                ? const NeverScrollableScrollPhysics()
                :
                //Web to Windows or MacOs or Linux
                const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16),
        controller: viewModel.scrollController,
        itemCount: viewModel.products.length,
        itemBuilder: (context, index) =>
            _cartItem(context, viewModel.products[index], index),
      ),
    );
  }

  _cartItem(BuildContext context, Product product, int index) {
    return Padding(
        padding: const EdgeInsets.all(26),
        child: ListTile(
          leading: AdaptiveImage(
            key: UniqueKey(),
            width: 100,
            height: 100,
            altImage: 'image of product: ${product.images[0]}',
            srcImage: product.images[0],
            imageName: 'image${Random().nextInt(100000)}',
            hint: 'image of product: ${product.images[0]}',
            label: 'image of product: ${product.images[0]}',
            value: 'image of product: ${product.images[0]}',
          ),
          title: AdaptiveText(
            text: product.title,
            headerText: product.title,
            headerType: TextRendererStyle.header5,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w400),
            textAlign: TextAlign.start,
            hint: product.title,
            label: product.title,
            value: product.title,
          ),
          subtitle: AdaptiveText(
            text: product.price.toString() + '\$',
            headerText: product.price.toString(),
            headerType: TextRendererStyle.header6,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w300,
                color: Theme.of(context).primaryColor),
            textAlign: TextAlign.start,
            hint: product.price.toString(),
            label: product.price.toString(),
            value: product.price.toString(),
          ),
          trailing: IncrementButton(
            padding: const EdgeInsets.all(3),
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(300),
            fontWeight: FontWeight.w500,
            textColor: Theme.of(context).primaryColor,
            textSize: 25,
            colorArrowIcon: Theme.of(context).primaryColor,
            sizeArrowIcon: 23,
            product: product,
            viewModel: viewModel,
            value: product.quantity,
            index: index,
          ),
        ));
  }
}

// ignore: must_be_immutable
class IncrementButton extends StatefulWidget {
  IncrementButton(
      {Key? key,
      this.padding = EdgeInsets.zero,
      this.color = Colors.transparent,
      this.borderRadius = BorderRadius.zero,
      this.sizeArrowIcon = 15,
      this.colorArrowIcon = Colors.blue,
      this.textSize = 18,
      this.textColor = Colors.black,
      this.fontWeight = FontWeight.normal,
      required this.viewModel,
      required this.product,
      required this.index,
      required this.value})
      : super(key: key);

  final EdgeInsets padding;
  final Color color;
  final BorderRadius borderRadius;
  final double sizeArrowIcon;
  final Color colorArrowIcon;
  final double textSize;
  final Color textColor;
  final FontWeight fontWeight;

  final int index;
  CartViewModel viewModel;
  Product product;

  int value;

  late AnimationController animationController;

  @override
  State<StatefulWidget> createState() => _IncrementButtonState();
}

class _IncrementButtonState extends State<IncrementButton>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // widget.animationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 24.0)
    //     .chain(CurveTween(curve: Curves.elasticIn))
    //     .animate(widget.animationController)
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       widget.animationController.reverse();
    //     }
    //   });

    return Container(
      padding: widget.padding,
      decoration:
          BoxDecoration(color: widget.color, borderRadius: widget.borderRadius),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          //////////////////////// * Left Arrow * ////////////////////////
          Flexible(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: FaIcon(
                  FontAwesomeIcons.circleArrowLeft,
                  color: widget.colorArrowIcon,
                  size: widget.sizeArrowIcon,
                ),
                onTap: () async {
                  if (widget.value > 1) {
                    widget.value--;
                    changeState();
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            width: 14,
          ),

          //////////////////////// * Value * ////////////////////////
          Semantics(
            selected: true,
            readOnly: true,
            header: true,
            hint: 'Badge value',
            value: 'Badge value',
            label: 'Badge value',
            child: Text(
              widget.value.toString(),
              style: GoogleFonts.montserrat(
                fontSize: widget.textSize,
                fontWeight: widget.fontWeight,
                color: widget.textColor,
              ),
            ),
          ),

          //////////////////////// * Right Arrow * ////////////////////////
          const SizedBox(
            width: 14,
          ),
          Flexible(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: FaIcon(
                  FontAwesomeIcons.circleArrowRight,
                  color: widget.colorArrowIcon,
                  size: widget.sizeArrowIcon,
                ),
                onTap: () {
                  if (widget.value < 50) {
                    widget.value++;
                    changeState();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changeState() {
    widget.product.quantity = widget.value;

    //change product quantity inside the database
    widget.viewModel.updateQuantityProduct(widget.product);

    //change product quantity inside view model
    widget.viewModel.products[widget.index].quantity = widget.value;

    //Change total Value
    widget.viewModel.cartTotalValueNotifier
        .updateTotalValue(widget.viewModel.calculateTotalPrice());

    //refresh list data
    widget.viewModel.cartStateProducts
        .updateState(ProductsState.success([])); //No important the value

    setState(() {});
  }
}
