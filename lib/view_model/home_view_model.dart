import 'package:Products/utils/router/routers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

// @Injectable()
class HomeViewModel {
  late ScrollController scrollController;

  HomeViewModel() {
    scrollController = ScrollController();
  }

  /* Links */
  Future<void> launchLink(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(Uri.parse(url));
    }
  }

  /* Navigation */
  void goLogin(BuildContext context) =>
      GoRouter.of(context).pushNamed(Routers.loginName);

  void goProducts(BuildContext context) =>
      GoRouter.of(context).pushNamed(Routers.productsName);
}
