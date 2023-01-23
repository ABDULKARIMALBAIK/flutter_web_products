import 'dart:math';
import 'dart:ui' as ui;

import 'package:Products/utils/responsive_sizer.dart';
import 'package:Products/widgets/adaptive_widgets/adaptive_wrap.dart';
import 'package:Products/widgets/smooth_scroll/smooth_scroll.dart';
import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
import 'package:seo_renderer/seo_renderer.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/link.dart';

import '../utils/app_color.dart';
import '../utils/constants.dart';
import '../utils/localization/app_localizations.dart';
import '../utils/resources_path.dart';
import '../utils/router/routers.dart';
import '../utils/urls.dart';
import '../view_model/home_view_model.dart';
import '../widgets/adaptive_widgets/adaptive_image.dart';
import '../widgets/adaptive_widgets/adaptive_link.dart';
import '../widgets/adaptive_widgets/adaptive_text.dart';
import '../widgets/clippers.dart';
import '../widgets/custom_dialog/custom_snack_bar.dart';
import '../widgets/custom_dialog/top_snack_bar.dart';

bool isCookiesFirstTime = true;

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key) {
    // viewModel = GetIt.I.get<HomeViewModel>();
    viewModel = HomeViewModel();
  }

  late HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (isCookiesFirstTime) {
      Future.delayed(const Duration(milliseconds: 10000))
          .then((value) => showCookiesDialog(context));
      isCookiesFirstTime = false;
    }

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            width: ResponsiveSizer.screenWidth(context),
            height: ResponsiveSizer.screenHeight(context),
            child: SmoothScroll(
              scrollController: viewModel.scrollController,
              scrollPhysics: const BouncingScrollPhysics(),
              scrollView: SingleChildScrollView(
                controller: viewModel.scrollController,
                physics:
                    //Web to Android or IOS OS
                    SmoothScroll.checkDesktop(context)
                        ? const NeverScrollableScrollPhysics()
                        :
                        //Web to Windows or MacOs or Linux
                        const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //////////////////////// * Header * ////////////////////////
                    HomeHeader(viewModel),

                    //////////////////////// * Modern Products * ////////////////////////
                    HomeModernProducts(viewModel),

                    // //////////////////////// * Fast Deliver * ////////////////////////
                    // const HomeFastDeliver(),

                    // //////////////////////// * Most beloved * ////////////////////////
                    // const HomeMostBeloved(),

                    // //////////////////////// * Login Ready * ////////////////////////
                    // HomeLoginReady(viewModel),

                    // //////////////////////// * Footer * ////////////////////////
                    // HomeFooter(viewModel)
                  ],
                ),
              ),
            )),
      ),
    );
  }

  _singleScrollChild(BuildContext context) {
    return;
  }

  void showCookiesDialog(BuildContext context) {
    showTopSnackBar(
        context,
        const CustomSnackBar.cookies(
          message:
              "We are using COOKIES to give your a good experience when you visit our website",
        ),
        displayDuration: const Duration(seconds: 20));
  }
}

/* HomeHeader Class */
// ignore: must_be_immutable
class HomeHeader extends StatelessWidget {
  HomeHeader(this.viewModel, {Key? key}) : super(key: key);

  HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ResponsiveSizer.screenWidth(context),
        height: ResponsiveSizer.screenHeight(context),
        child: ClipPath(
          clipper: HomeHeaderClipper(),
          child: Stack(
            children: [
              //////////////////////// * Background Image * ////////////////////////
              ImageRenderer(
                alt: 'Products header image',
                src: ResourcesPath.headerImage,
                child: Image.asset(ResourcesPath.headerImage,
                    fit: BoxFit.cover,
                    width: ResponsiveSizer.screenWidth(context),
                    height: ResponsiveSizer.screenHeight(context)),
              ),

              // AdaptiveImage(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height,
              //   altImage: 'products header image',
              //   srcImage: ResourcesPath.headerImage,
              //   hint: 'products header image',
              //   label: 'products header image',
              //   value: 'products header image',
              // ),

              //////////////////////// * Shadow Black * ////////////////////////
              Container(
                width: ResponsiveSizer.screenWidth(
                    context), //MediaQuery.of(context).size.width
                height: ResponsiveSizer.screenHeight(
                    context), //MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.8),
              ),

              //////////////////////// * Titles * ////////////////////////
              Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //////////////////////// * Title * ////////////////////////
                  AdaptiveText(
                    text: AppLocalizations.of(context)!
                        .translate('home_header_title'),
                    headerText: 'Products',
                    headerType: TextRendererStyle.header1,
                    style: ResponsiveSizer.responsiveText(
                        context, TextType.header1,
                        color: Colors.white,
                        shadows: const [
                          Shadow(color: Colors.blue, blurRadius: 12)
                        ]),
                    textAlign: TextAlign.center,
                    textScaleFactor: ResponsiveSizer.textScaleFactor(context,
                        maxTextScaleFactor: 2.8),
                    hint: 'Products',
                    label: 'Products',
                    value: 'Products',
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //////////////////////// * Subtitle * ////////////////////////
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AdaptiveText(
                      text: AppLocalizations.of(context)!
                          .translate('home_header_subtitle'),
                      headerText:
                          "Explore the latest modern products in the world",
                      headerType: TextRendererStyle.header2,
                      style: ResponsiveSizer.responsiveText(
                          context, TextType.header2,
                          color: Colors.white, fontWeight: FontWeight.w200),
                      textAlign: TextAlign.center,
                      hint: "Explore the latest modern products in the world",
                      label: "Explore the latest modern products in the world",
                      value: "Explore the latest modern products in the world",
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),

                  //////////////////////// * Products Login * ////////////////////////
                  AdaptiveLink(
                    link: Routers.productsRoute,
                    linkText: 'button link to Products Page',
                    target: LinkTarget.self,
                    hint: 'button link to Products Page',
                    label: 'button link to Products Page',
                    value: 'button link to Products Page',
                    widget: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(25),
                        primary: Theme.of(context).primaryColor,
                        shadowColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 16,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!
                            .translate('home_header_button_get_started'),
                        style: ResponsiveSizer.responsiveText(
                            context, TextType.header6,
                            minFontSize: 40, color: Colors.white),
                        textAlign: TextAlign.center,
                        textScaleFactor:
                            ResponsiveSizer.textScaleFactor(context),
                      ),
                      onPressed: () {
                        viewModel.goProducts(context);
                      },
                    ),
                  )
                ],
              ))
            ],
          ),
        ));
  }
}

/*  ModernProducts Class */
// ignore: must_be_immutable
class HomeModernProducts extends StatelessWidget {
  HomeModernProducts(this.viewModel, {Key? key}) : super(key: key);

  HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 30),
      child: SizedBox(
        width: ResponsiveSizer.screenWidth(context),
        child: WrapRow(
          wrapAlignment: WrapAlignment.spaceEvenly,
          sectionAlignment: WrapAlignment.center,
          wrapCrossAlignment: WrapCrossAlignment.center,
          sectionSpacing: 10,
          spacing: 2,
          // mainAxisSize: MainAxisSize.max,
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //////////////////////// * Text * ////////////////////////
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AdaptiveText(
                  text: AppLocalizations.of(context)!
                      .translate('home_modern_products_title'),
                  headerText: "Modern Products",
                  headerType: TextRendererStyle.header3,
                  style: ResponsiveSizer.responsiveText(
                      context, TextType.header3,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start,
                  hint: "Modern Products",
                  label: "Modern Products",
                  value: "Modern Products",
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: 500,
                  // width: ResponsiveSizer.responsiveWidth(
                  //     context, 500), //MediaQuery.of(context).size.width - 800
                  child: AdaptiveText(
                    text: AppLocalizations.of(context)!
                        .translate('home_modern_products_subtitle'),
                    headerText:
                        "We offer a lot of products which every one want has it, we care about your ideas and opinion and release latest version of our products",
                    headerType: TextRendererStyle.header6,
                    style: ResponsiveSizer.responsiveText(
                        context, TextType.header6,
                        fontWeight: FontWeight.w200),
                    textAlign: TextAlign.start,
                    maxLines: 4,
                    hint:
                        "We offer a lot of products which every one want has it, we care about your ideas and opinion and release latest version of our products",
                    label:
                        "We offer a lot of products which every one want has it, we care about your ideas and opinion and release latest version of our products",
                    value:
                        "We offer a lot of products which every one want has it, we care about your ideas and opinion and release latest version of our products",
                  ),
                ),
              ],
            ),

            //////////////////////// * Image * ////////////////////////
            AdaptiveImage(
              key: UniqueKey(),
              // width: 660,
              // height: 660,
              width: ResponsiveSizer.responsiveWidth(context, 500),
              height: ResponsiveSizer.responsiveWidth(context, 500),
              altImage: 'modern products image',
              srcImage: ResourcesPath.modernProductsImage,
              imageName: 'image${Random().nextInt(100000)}',
              hint: 'modern products image',
              label: 'modern products image',
              value: 'modern products image',
            ),
          ],
        ),
      ),
    );
  }
}

/*  Fast Deliver Class */
class HomeFastDeliver extends StatelessWidget {
  const HomeFastDeliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: DataHelper.isDark
            ? AppColor().backgroundColorLight()
            : AppColor().backgroundColorDark(),
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 30),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //////////////////////// * Image * ////////////////////////
            AdaptiveImage(
              key: UniqueKey(),
              width: 660,
              height: 660,
              altImage: 'fast delivery products image',
              srcImage: ResourcesPath.fastDeliverImage,
              imageName: 'image${Random().nextInt(100000)}',
              hint: 'fast delivery products image',
              label: 'fast delivery products image',
              value: 'fast delivery products image',
            ),

            //////////////////////// * Text * ////////////////////////
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AdaptiveText(
                  text: AppLocalizations.of(context)!
                      .translate('home_fast_deliver_title'),
                  headerText: "Fast Delivery",
                  headerType: TextRendererStyle.header3,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: DataHelper.isDark
                          ? AppColor().textTitleColorLight()
                          : AppColor().textTitleColorDark()),
                  textAlign: TextAlign.start,
                  hint: "Fast Delivery",
                  label: "Fast Delivery",
                  value: "Fast Delivery",
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 800,
                  child: AdaptiveText(
                    text: AppLocalizations.of(context)!
                        .translate('home_fast_deliver_subtitle'),
                    headerText:
                        "We offer a lot of products which every one want has it, we care about your ideas and opinion and release latest version of our products",
                    headerType: TextRendererStyle.header6,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w200,
                        color: DataHelper.isDark
                            ? AppColor().textTitleColorLight()
                            : AppColor().textTitleColorDark()),
                    textAlign: TextAlign.start,
                    maxLines: 4,
                    hint:
                        "You think the distance is such as a issue, be relax, we have many of delivering center that were made it for you, your needs are our desire",
                    label:
                        "You think the distance is such as a issue, be relax, we have many of delivering center that were made it for you, your needs are our desire",
                    value:
                        "You think the distance is such as a issue, be relax, we have many of delivering center that were made it for you, your needs are our desire",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*  Most Beloved Class */
class HomeMostBeloved extends StatelessWidget {
  const HomeMostBeloved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 30),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //////////////////////// * Text * ////////////////////////
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AdaptiveText(
                text: AppLocalizations.of(context)!
                    .translate('home_most_beloved_title'),
                headerText: "Most Beloved",
                headerType: TextRendererStyle.header3,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.w400),
                textAlign: TextAlign.start,
                hint: "Most Beloved",
                label: "Most Beloved",
                value: "Most Beloved",
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 800,
                child: AdaptiveText(
                  text: AppLocalizations.of(context)!
                      .translate('home_most_beloved_subtitle'),
                  headerText:
                      "our clients are trust us for their requirements and always happy and satisfied, so we highly recommend you to use our products",
                  headerType: TextRendererStyle.header6,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w200),
                  textAlign: TextAlign.start,
                  maxLines: 4,
                  hint:
                      "our clients are trust us for their requirements and always happy and satisfied, so we highly recommend you to use our products",
                  label:
                      "our clients are trust us for their requirements and always happy and satisfied, so we highly recommend you to use our products",
                  value:
                      "our clients are trust us for their requirements and always happy and satisfied, so we highly recommend you to use our products",
                ),
              ),
            ],
          ),

          //////////////////////// * Image * ////////////////////////
          AdaptiveImage(
            key: UniqueKey(),
            width: 660,
            height: 660,
            altImage: 'Most Beloved Products image',
            srcImage: ResourcesPath.mostBelovedImage,
            imageName: 'image${Random().nextInt(100000)}',
            hint: 'Most Beloved Products image',
            label: 'Most Beloved Products image',
            value: 'Most Beloved Products image',
          ),
        ],
      ),
    );
  }
}

/*  Login Ready Class */
// ignore: must_be_immutable
class HomeLoginReady extends StatelessWidget {
  HomeLoginReady(this.viewModel, {Key? key}) : super(key: key);

  HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 0, right: 0, top: 30, bottom: 0), //horizontal: 0, vertical: 30
      child: Container(
          width: MediaQuery.of(context).size.width,
          color: DataHelper.isDark
              ? AppColor().backgroundColorLight()
              : AppColor().backgroundColorDark(),
          padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //////////////////////// * Title * ////////////////////////
              const SizedBox(
                height: 30,
              ),
              AdaptiveText(
                text: AppLocalizations.of(context)!
                    .translate('home_login_ready_title'),
                headerText: "Join",
                headerType: TextRendererStyle.header3,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: DataHelper.isDark
                        ? AppColor().textTitleColorLight()
                        : AppColor().textTitleColorDark()),
                textAlign: TextAlign.center,
                hint: "Join",
                label: "Join",
                value: "Join",
              ),
              const SizedBox(
                height: 25,
              ),

              //////////////////////// * Subtitle * ////////////////////////
              AdaptiveText(
                text: AppLocalizations.of(context)!
                    .translate('home_login_ready_subtitle'),
                headerText:
                    "Come with us and be one of thousands of people around the world !Enjoy!",
                headerType: TextRendererStyle.header5,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w200,
                    color: DataHelper.isDark
                        ? AppColor().textTitleColorLight()
                        : AppColor().textTitleColorDark()),
                textAlign: TextAlign.center,
                maxLines: 3,
                hint:
                    "Come with us and be one of thousands of people around the world !Enjoy!",
                label:
                    "Come with us and be one of thousands of people around the world !Enjoy!",
                value:
                    "Come with us and be one of thousands of people around the world !Enjoy!",
              ),
              const SizedBox(
                height: 40,
              ),

              //////////////////////// * Button Login * ////////////////////////
              AdaptiveLink(
                link: Routers.loginRoute,
                linkText: 'Login Page',
                target: LinkTarget.self,
                hint: 'Login Page',
                label: 'Login Page',
                value: 'Login Page',
                widget: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(25),
                    primary: Theme.of(context).primaryColor,
                    shadowColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 16,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!
                        .translate('home_login_ready_button_text'),
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    viewModel.goLogin(context);
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              //////////////////////// * Show Ads * ////////////////////////
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // AdWidget(
                  //   key: UniqueKey(),
                  //   width: 320,
                  //   height: 80,
                  //   adName: 'product_ad_${Random().nextInt(10000)}',
                  //   value: 'Product Ad 1',
                  //   label: 'Product Ad 1',
                  //   hint: 'Product Ad 1',
                  // ),
                  SizedBox(
                    width: 25,
                  ),
                  // AdWidget(
                  //   key: UniqueKey(),
                  //   width: 320,
                  //   height: 80,
                  //   adName: 'product_ad_${Random().nextInt(10000)}',
                  //   value: 'Product Ad 2',
                  //   label: 'Product Ad 2',
                  //   hint: 'Product Ad 2',
                  // ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          )),
    );
  }
}

/* Footer Class */
// ignore: must_be_immutable
class HomeFooter extends StatelessWidget {
  HomeFooter(this.viewModel, {Key? key}) : super(key: key);

  HomeViewModel viewModel;

  static const Text verticalDivider =
      Text('   |   ', style: TextStyle(color: Colors.white));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: const Color(0xff151515),
      padding: const EdgeInsets.all(30),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //////////////////////// * Links  * ////////////////////////
              const SizedBox(
                height: 25,
              ),
              Wrap(
                children: [
                  //////////////////////// * Privacy Policy * ////////////////////////
                  AdaptiveLink(
                    link: ConstUrls.privacyPolicy,
                    linkText: 'Privacy Policy',
                    target: LinkTarget.blank,
                    hint: 'Privacy Policy',
                    label: 'Privacy Policy',
                    value: 'Privacy Policy',
                    onTap: () async {
                      viewModel.launchLink(ConstUrls.privacyPolicy);
                    },
                    widget: Text(
                      AppLocalizations.of(context)!
                          .translate('home_footer_privacy'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  verticalDivider,

                  //////////////////////// * Terms of Service * ////////////////////////
                  AdaptiveLink(
                    link: ConstUrls.termsService,
                    linkText: 'Terms of Service',
                    target: LinkTarget.blank,
                    hint: 'Terms of Service',
                    label: 'Terms of Service',
                    value: 'Terms of Service',
                    onTap: () async {
                      viewModel.launchLink(ConstUrls.termsService);
                    },
                    widget: Text(
                      AppLocalizations.of(context)!
                          .translate('home_terms_service'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  verticalDivider,

                  //////////////////////// * FAQ's * ////////////////////////
                  AdaptiveLink(
                    link: ConstUrls.faqs,
                    linkText: 'FAQ\'s',
                    target: LinkTarget.blank,
                    hint: 'FAQ\'s',
                    label: 'FAQ\'s',
                    value: 'FAQ\'s',
                    onTap: () async {
                      viewModel.launchLink(ConstUrls.faqs);
                    },
                    widget: Text(
                      AppLocalizations.of(context)!
                          .translate('home_footer_faqs'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  verticalDivider,

                  //////////////////////// * Blog * ////////////////////////
                  AdaptiveLink(
                    link: ConstUrls.blog,
                    linkText: 'Blog',
                    target: LinkTarget.blank,
                    hint: 'Blog',
                    label: 'Blog',
                    value: 'Blog',
                    onTap: () async {
                      viewModel.launchLink(ConstUrls.blog);
                    },
                    widget: Text(
                      AppLocalizations.of(context)!
                          .translate('home_footer_blog'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  verticalDivider,

                  //////////////////////// * About * ////////////////////////
                  AdaptiveLink(
                    link: ConstUrls.about,
                    linkText: 'About',
                    target: LinkTarget.blank,
                    hint: 'About',
                    label: 'About',
                    value: 'About',
                    onTap: () async {
                      viewModel.launchLink(ConstUrls.about);
                    },
                    widget: Text(
                      AppLocalizations.of(context)!
                          .translate('home_footer_about'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  verticalDivider,

                  //////////////////////// * Contact Us * ////////////////////////
                  AdaptiveLink(
                    link: ConstUrls.contactUs,
                    linkText: 'Contact Us',
                    target: LinkTarget.blank,
                    hint: 'Contact Us',
                    label: 'Contact Us',
                    value: 'Contact Us',
                    onTap: () async {
                      viewModel.launchLink(ConstUrls.contactUs);
                    },
                    widget: Text(
                      AppLocalizations.of(context)!
                          .translate('home_footer_contact_us'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),

              //////////////////////// * Social Media  * ////////////////////////
              _shareMediaQuery(
                  context, 'share${Random().nextInt(100000)}', UniqueKey()),

              //////////////////////// * Mark Developer Website  * ////////////////////////
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, bottom: 30, top: 8),
                child: Center(
                  child: AdaptiveText(
                    text: AppLocalizations.of(context)!
                        .translate('home_footer_developer_rights'),
                    headerText:
                        "© 2022 All Rights Reserved to ABDULKARIM ALBAIK ",
                    headerType: TextRendererStyle.header6,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w200,
                        color: DataHelper.isDark
                            ? AppColor().textTitleColorLight().withOpacity(0.4)
                            : AppColor().textTitleColorDark().withOpacity(0.4)),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    hint: "© 2022 All Rights Reserved to ABDULKARIM ALBAIK ",
                    label: "© 2022 All Rights Reserved to ABDULKARIM ALBAIK ",
                    value: "© 2022 All Rights Reserved to ABDULKARIM ALBAIK ",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _shareMediaQuery(BuildContext context, String name, Key key) {
    return Builder(
      builder: (context) {
        // ignore: undefined_prefixed_name
        ui.platformViewRegistry.registerViewFactory(
            name,
            (int viewId) => html.IFrameElement()
              ..width = '500px'
              ..height = '200px'
              ..style.width = "500px"
              ..style.height = "200px"
              ..style.border = 'none'
              ..style.padding = '5px'
              ..style.margin = '0px'
              ..srcdoc = """<!DOCTYPE html>
                               <html>
                                <body scroll="no" style="overflow: hidden">
                                    <div id="shareButton">
                                      <div class="a2a_kit a2a_kit_size_32 a2a_default_style">
                                        <a class="a2a_dd" href="https://www.addtoany.com/share"></a>
                                        <a class="a2a_button_facebook"></a>
                                        <a class="a2a_button_twitter"></a>
                                        <a class="a2a_button_linkedin"></a>
                                        <a class="a2a_button_pinterest"></a>
                                        <a class="a2a_button_reddit"></a>
                                        <a class="a2a_button_email"></a>
                                      </div>
                                      <script>
	                                  		var a2a_config = a2a_config || {};
	                                  		a2a_config.num_services = 6;
	                                  		</script>
                                      <script async src="https://static.addtoany.com/menu/page.js"></script>
                                    </div>
                                </body>
                              </html>""");

        return SizedBox(
          width: 300,
          height: 150,
          child: HtmlElementView(
            key: key,
            viewType: name,
          ),
        );
      },
    );
  }
}
