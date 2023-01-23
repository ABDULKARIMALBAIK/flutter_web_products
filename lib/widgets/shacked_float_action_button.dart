import 'package:badges/badges.dart';
import 'package:Products/view_model/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/products_model.dart';

// ignore: must_be_immutable
class ShackedFloatActionButton extends StatefulWidget {
  ShackedFloatActionButton(this.badgeCount, this.productsViewModel, {Key? key})
      : super(key: key);

  ProductsViewModel productsViewModel;
  String badgeCount;

  // late AnimationController animationController;

  @override
  State<ShackedFloatActionButton> createState() =>
      _ShackedFloatActionButtonState();
}

class _ShackedFloatActionButtonState extends State<ShackedFloatActionButton>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
      });

    return AnimatedBuilder(
        animation: offsetAnimation,
        child: _floatActionButton(context, animationController),
        builder: (buildContext, child) {
          if (offsetAnimation.value < 0.0) {
            debugPrint('${offsetAnimation.value + 8.0}');
          }
          return Padding(
            padding: EdgeInsets.only(
                top: offsetAnimation.value + 24.0,
                bottom: 24.0 - offsetAnimation.value),
            child: child,
          );
        });
  }

  _floatActionButton(
      BuildContext context, AnimationController animationController) {
    return DragTarget<Product>(
      onAccept: (product) async {
        //Save in database
        widget.productsViewModel.saveProductStorage(product);

        //Change Badge
        widget.badgeCount =
            (await widget.productsViewModel.countProductStorage()).toString();
        setState(() {});

        //Run sound
        widget.productsViewModel.playAddProductsSound();

        //Run Animation
        animationController.forward(from: 0.0);
      },
      builder: (context, products, dynamics) {
        return Badge(
          badgeContent: Text(
            widget.badgeCount,
            style: const TextStyle(color: Colors.white),
          ),
          badgeColor: Theme.of(context).primaryColor,
          showBadge: widget.badgeCount != '0' ? true : false,
          elevation: 2,
          toAnimate: true,
          position: BadgePosition.topEnd(),
          shape: BadgeShape.circle,
          animationType: BadgeAnimationType.scale,
          child: FloatingActionButton(
            mouseCursor: SystemMouseCursors.click,
            splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
            child: FaIcon(FontAwesomeIcons.cartPlus,
                color: Theme.of(context).primaryColor),
            elevation: 12,
            backgroundColor: Theme.of(context).backgroundColor,
            onPressed: () {
              widget.productsViewModel.goCart(context);

              // showTopSnackBar(
              //     context,
              //     const CustomSnackBar.info(
              //       message: 'Cart Screen',
              //       //textStyle: textStyle,
              //       // backgroundColor: ,
              //       // icon: ,
              //       // iconRotationAngle: ,
              //     )
              // );
            },
          ),
        );
      },
    );
  }
}
