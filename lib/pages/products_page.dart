import 'dart:async';

import 'package:Products/pages/shimmer/products_shimmer.dart';
import 'package:Products/widgets/adaptive_widgets/adaptive_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get_it/get_it.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'package:seo_renderer/seo_renderer.dart';

import '../model/products_model.dart';
import '../notifier/products_notifier.dart';
import '../state/products_state.dart';
import '../utils/localization/app_localizations.dart';
import '../utils/platform_detector.dart';
import '../utils/resources_path.dart';
import '../view_model/products_view_model.dart';
import '../widgets/data_template.dart';
import '../widgets/shacked_float_action_button.dart';
import '../widgets/smooth_scroll/custom_scroll_behavior.dart';

// ignore: must_be_immutable
class ProductsPage extends StatefulWidget {
  ProductsPage({Key? key}) : super(key: key) {
    // viewModel = GetIt.I.get<ProductsViewModel>();
    viewModel = ProductsViewModel();
    productsState = viewModel.productsState;
    // connectivityChecker = viewModel.checkConnectionInternet;
  }

  late ProductsViewModel viewModel;
  late ProductsStateNotifier productsState;
  // late final Future<ConnectivityResult> connectivityChecker;

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 6000)).then((value) {
      widget.viewModel.fetchNextPageProducts();
    });

    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButton: ShackedFloatActionButton('0', widget.viewModel),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _productsData(context, widget.viewModel)),
      ),
    );
  }

  Widget _productsData(BuildContext context, ProductsViewModel viewModel) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ChangeNotifierProvider<ProductsStateNotifier>.value(
        value: widget.productsState,
        child: Consumer<ProductsStateNotifier>(
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
                return const ProductsShimmer(); //const ProductsShimmer();
              }

              //////////////////////// * NoData * ////////////////////////
              else if (productsState is ProductsNoData) {
                //print('is NoData now');
                return DataTemplate().noData(
                    context: context,
                    widthImage: 300,
                    heightImage: 300,
                    text: AppLocalizations.of(context)!.translate('no_data'),
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
                ProductsSuccess success = productsState;
                List<Product> data = success.products;

                if (data.isEmpty) {
                  //print('is NoData of list now');
                  return DataTemplate().noData(
                      context: context,
                      widthImage: 300,
                      heightImage: 300,
                      text: AppLocalizations.of(context)!.translate('no_data'),
                      style: Theme.of(context).textTheme.headline6,
                      imageLinkAssets: ResourcesPath().noData);
                } else {
                  //print('data: ${data.length}');

                  Future.delayed(const Duration(milliseconds: 2000));

                  return _productsGrid(context, data);
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
      ),
    );
  }

  Widget _productsGrid(BuildContext context, List<Product> products) {
    return Stack(
      children: [
        ////////////////////////////////// * Grid Products * //////////////////////////////////
        //Web for mobile (Android & IOS)
        PlatformDetector().isWeb() &&
                (Theme.of(context).platform == TargetPlatform.iOS ||
                    Theme.of(context).platform == TargetPlatform.android)
            ? _singleScrollChild(context, products)
            :
            //Web for Desktops (Windows-MacOS-Linux)
            _desktopWebScroller(context, products),

        ////////////////////////////////// * Grid Products * //////////////////////////////////
        _paginationIndicator(context, widget.viewModel),
      ],
    );
  }

  _desktopWebScroller(BuildContext context, List<Product> products) {
    return ImprovedScrolling(
        scrollController: widget.viewModel.scrollController,
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
          child: _singleScrollChild(context, products),
        ));
  }

  _singleScrollChild(BuildContext context, List<Product> products) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: GridView.builder(
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
        controller: widget.viewModel.scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height * 2.1), // width/height
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 5,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) =>
            ProductItem(products[index], widget.viewModel),
      ),
    );
  }

  Positioned _paginationIndicator(
      BuildContext context, ProductsViewModel viewModel) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(30)),
              child: ChangeNotifierProvider<PaginationNumber>(
                create: (context) => widget.viewModel.paginationNumber,
                builder: (context, widget) {
                  return Consumer<PaginationNumber>(
                    builder: (context, paginationNumber, child) {
                      return Pagination(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        width: MediaQuery.of(context).size.width *
                            .5, // this prop is optional
                        paginateButtonStyles: PaginateButtonStyles(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          activeBackgroundColor: Theme.of(context).primaryColor,
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Theme.of(context).primaryColor),
                          activeTextStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                          // fontSize: ,
                          paginateButtonBorderRadius: BorderRadius.circular(30),
                        ),
                        prevButtonStyles: PaginateSkipButton(
                            buttonBackgroundColor:
                                Theme.of(context).primaryColor,
                            icon: const Icon(
                              FontAwesomeIcons.arrowLeft,
                              size: 18,
                              color: Colors.white,
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        nextButtonStyles: PaginateSkipButton(
                            buttonBackgroundColor:
                                Theme.of(context).primaryColor,
                            icon: const Icon(
                              FontAwesomeIcons.arrowRight,
                              size: 18,
                              color: Colors.white,
                            ),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        onPageChange: (number) {
                          paginationNumber.updatePageIndex(number);
                          viewModel.fetchNextPageProducts();
                        },
                        useGroup: true,
                        totalPage: paginationNumber.totalPages,
                        show: 4,
                        currentPage: paginationNumber.currentPageIndex,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

// ignore: must_be_immutable
class ProductItem extends StatefulWidget {
  ProductItem(this.product, this.viewModel, {Key? key}) : super(key: key);

  Product product;
  ProductsViewModel viewModel;

  @override
  State<StatefulWidget> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, double obj, widget) {
        return AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            opacity: obj,
            child: widget!);
      },
      child: SizedBox(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Draggable(
              data: widget.product,
              onDragStarted: () {
                //Run sound effect
                widget.viewModel.playDragProductsSound();
              },
              feedback: _productDraggable(context, widget.product),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ImageRenderer(
                  alt: 'product: ${widget.product.images[0]}',
                  src: widget.product.images[0],
                  child: Semantics(
                    image: true,
                    readOnly: true,
                    label: 'product: ${widget.product.images[0]}',
                    hint: 'product: ${widget.product.images[0]}',
                    value: 'product: ${widget.product.images[0]}',
                    child: OctoImage(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      image:
                          CachedNetworkImageProvider(widget.product.images[0]),
                      placeholderBuilder:
                          OctoPlaceholder.circularProgressIndicator(),
                      errorBuilder: OctoError.icon(color: Colors.red),
                      fit: BoxFit.cover,
                      fadeInCurve: Curves.easeIn,
                      fadeOutCurve: Curves.easeOut,
                      fadeInDuration: const Duration(milliseconds: 300),
                      fadeOutDuration: const Duration(milliseconds: 300),
                      placeholderFadeInDuration:
                          const Duration(milliseconds: 300),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: AdaptiveText(
                text: widget.product.title,
                headerText: "Name of product",
                headerType: TextRendererStyle.header6,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.w200),
                textAlign: TextAlign.center,
                maxLines: 1,
                hint: "Name of product",
                label: "Name of product",
                value: "Name of product",
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: AdaptiveText(
                text: '${widget.product.price.toString()} \$',
                headerText: "Price of product",
                headerType: TextRendererStyle.header6,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w200,
                    color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
                maxLines: 1,
                hint: "Price of product",
                label: "Price of product",
                value: "Price of product",
              ),
            ),
          ),
        ],
      )),
    );
  }

  _productDraggable(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Opacity(
        opacity: 1,
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: Theme.of(context).primaryColor,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                  product.images[0]), //product.imageUrl!
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1),
            ],
          ),
        ),
      ),
    );
  }
}
