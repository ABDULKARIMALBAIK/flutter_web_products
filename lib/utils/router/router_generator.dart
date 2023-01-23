import 'package:Products/pages/cart_page.dart' deferred as cart_page;
import 'package:Products/pages/home_page.dart' deferred as home_page;
import 'package:Products/pages/login_page.dart' deferred as login_page;
import 'package:Products/pages/register_page.dart' deferred as register_page;
import 'package:Products/pages/products_page.dart' deferred as products_page;
import 'package:Products/pages/not_found_page.dart' deferred as not_found_page;

import 'package:Products/utils/router/routers.dart';
import 'package:Products/widgets/deferred_widget.dart';
import 'package:flutter/material.dart'
    show
        NavigatorObserver,
        FadeTransition,
        Center,
        Container,
        Builder,
        Theme,
        MediaQuery,
        Colors;
import 'package:go_router/go_router.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart'
    show SleekCircularSlider, CircularSliderAppearance, CustomSliderColors;

class RouteGenerator {
  static final GoRouter _router = GoRouter(
    initialLocation: Routers.homeRoute,
    routerNeglect: false, //Enable
    observers: [NavigatorObserver()],

    errorBuilder: (context, state) => DeferredWidget(
      libraryLoader: not_found_page.loadLibrary,
      createWidget: () => not_found_page.NotFoundPage(),
      placeholder: loaderWidget(),
    ),

    routes: [
      GoRoute(
          path: Routers.homeRoute,
          name: Routers.homeName,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: DeferredWidget(
                  libraryLoader: home_page.loadLibrary,
                  createWidget: () => home_page.HomePage(),
                  placeholder: loaderWidget(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              )),
      GoRoute(
          path: Routers.loginRoute,
          name: Routers.loginName,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: DeferredWidget(
                  libraryLoader: login_page.loadLibrary,
                  createWidget: () => login_page.LoginPage(),
                  placeholder: loaderWidget(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              )),
      GoRoute(
          path: Routers.registerRoute,
          name: Routers.registerName,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: DeferredWidget(
                  libraryLoader: register_page.loadLibrary,
                  createWidget: () => register_page.RegisterPage(),
                  placeholder: loaderWidget(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              )),
      GoRoute(
          path: Routers.productsRoute,
          name: Routers.productsName,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: DeferredWidget(
                  libraryLoader: products_page.loadLibrary,
                  createWidget: () => products_page.ProductsPage(),
                  placeholder: loaderWidget(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              )),
      GoRoute(
          path: Routers.cartRoute,
          name: Routers.cartName,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: DeferredWidget(
                  libraryLoader: cart_page.loadLibrary,
                  createWidget: () => cart_page.CartPage(),
                  placeholder: loaderWidget(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              )),
    ],
  );

  static GoRouter getRouters() {
    return _router;
  }

  static Builder loaderWidget() {
    return Builder(
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: SleekCircularSlider(
                appearance: CircularSliderAppearance(
                    spinnerMode: true,
                    customColors: CustomSliderColors(progressBarColors: [
                      Colors.red,
                      Colors.green,
                      Colors.blue,
                      Colors.pinkAccent,
                      Colors.yellowAccent,
                      Colors.deepOrange
                    ]))),
          ),
        );
      },
    );
  }
}
