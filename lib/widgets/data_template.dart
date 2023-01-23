import 'dart:math';

import 'package:Products/utils/platform_detector.dart';
import 'package:Products/widgets/adaptive_widgets/adaptive_text.dart';
import 'package:flutter/material.dart'
    show
        Widget,
        BuildContext,
        TextStyle,
        Center,
        Column,
        MainAxisAlignment,
        UniqueKey,
        SizedBox,
        Flexible,
        TextAlign;
import 'package:seo_renderer/seo_renderer.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'adaptive_widgets/adaptive_image.dart';

class DataTemplate {
  //Those can customized it to having lottie animation

  //No Data Screen
  Widget noData(
      {BuildContext? context,
      String? imageLinkAssets,
      double? widthImage,
      double? heightImage,
      String? text,
      TextStyle? style}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AdaptiveImage(
            key: UniqueKey(),
            width: widthImage ?? 300,
            height: heightImage ?? 300,
            imageName: 'image${Random().nextInt(10000)}',
            srcImage: imageLinkAssets!,
            altImage: 'No Data image',
            label: 'No Data image',
            value: 'No Data image',
            hint: 'No Data image',
          ),

          const SizedBox(
            height: 18,
          ),

          Flexible(
            child: AdaptiveText(
              text: text ?? '',
              headerText: 'Data image',
              headerType: TextRendererStyle.header6,
              style: style!,
              textAlign: TextAlign.center,
              maxLines: 1,
              hint: 'No Data image',
              label: 'No Data image',
              value: 'No Data image',
            ),
          )

          // Image.asset(
          //   imageLinkAssets!,
          //   width: widthImage,
          //   height: heightImage,
          //   fit: BoxFit.contain,
          // ),
          // const SizedBox(
          //   height: 18,
          // ),
          // Flexible(
          //     child: Text(
          //   text!,
          //   style: style,
          //   textAlign: TextAlign.center,
          //   overflow: TextOverflow.ellipsis,
          // )),
        ],
      ),
    );
  }

  //No Internet Screen
  Widget noInternet(
      {BuildContext? context,
      String? imageLinkAssets,
      double? widthImage,
      double? heightImage,
      String? text,
      TextStyle? style}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AdaptiveImage(
            key: UniqueKey(),
            width: widthImage ?? 300,
            height: heightImage ?? 300,
            imageName: 'image${Random().nextInt(10000)}',
            srcImage: imageLinkAssets!,
            altImage: 'No Internet image',
            label: 'No Internet image',
            value: 'No Internet image',
            hint: 'No Internet image',
          ),

          const SizedBox(
            height: 18,
          ),

          Flexible(
            child: AdaptiveText(
              text: text ?? '',
              headerText: 'Error image',
              headerType: TextRendererStyle.header6,
              style: style!,
              textAlign: TextAlign.center,
              maxLines: 1,
              hint: 'No Internet image',
              label: 'No Internet image',
              value: 'No Internet image',
            ),
          )

          // Image.asset(
          //   imageLinkAssets!,
          //   width: widthImage,
          //   height: heightImage,
          //   fit: BoxFit.contain,
          // ),
          // const SizedBox(
          //   height: 18,
          // ),
          // Flexible(
          //     child: Text(
          //   text!,
          //   style: style,
          //   textAlign: TextAlign.center,
          //   overflow: TextOverflow.ellipsis,
          // )),
        ],
      ),
    );
  }

  //Error Screen
  Widget error(
      {BuildContext? context,
      String? imageLinkAssets,
      double? widthImage,
      double? heightImage,
      String? text,
      TextStyle? style}) {
    return PlatformDetector().isWeb()
        ? noInternet(
            context: context,
            imageLinkAssets: imageLinkAssets,
            widthImage: widthImage,
            heightImage: heightImage,
            text: PlatformDetector().isWeb() ? 'You are offline' : text,
            style: style,
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AdaptiveImage(
                  key: UniqueKey(),
                  width: widthImage ?? 300,
                  height: heightImage ?? 300,
                  imageName: 'image${Random().nextInt(10000)}',
                  srcImage: imageLinkAssets!,
                  altImage: 'Error image',
                  label: 'Error image',
                  value: 'Error image',
                  hint: 'Error image',
                ),

                const SizedBox(
                  height: 18,
                ),

                Flexible(
                  child: AdaptiveText(
                    text: text ?? '',
                    headerText: 'Error image',
                    headerType: TextRendererStyle.header6,
                    style: style!,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    hint: 'Error image',
                    label: 'Error image',
                    value: 'Error image',
                  ),
                )

                // Image.asset(
                //   imageLinkAssets!,
                //   width: widthImage,
                //   height: heightImage,
                //   fit: BoxFit.contain,
                // ),
                // const SizedBox(
                //   height: 18,
                // ),
                // Flexible(
                //     child: Text(
                //   text!,
                //   style: style,
                //   textAlign: TextAlign.center,
                //   overflow: TextOverflow.ellipsis,
                // )),
              ],
            ),
          );
  }

  //Loading Screen
  Widget loading(BuildContext context) {
    return const Center(
        child: SleekCircularSlider(
            appearance: CircularSliderAppearance(
      spinnerMode: true,
      // customColors: CustomSliderColors(color)
    )));
  }

  //Not Found Page Screen
  Widget notFoundPage(
      {BuildContext? context,
      String? imageLinkAssets,
      double? widthImage,
      double? heightImage,
      String? text,
      TextStyle? style}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AdaptiveImage(
            key: UniqueKey(),
            width: widthImage ?? 300,
            height: heightImage ?? 300,
            imageName: 'image${Random().nextInt(10000)}',
            srcImage: imageLinkAssets!,
            altImage: 'Page no found image',
            label: 'Page no found image',
            value: 'Page no found image',
            hint: 'Page no found image',
          ),

          const SizedBox(
            height: 18,
          ),

          Flexible(
            child: AdaptiveText(
              text: text ?? '',
              headerText: "Page not found text ",
              headerType: TextRendererStyle.header6,
              style: style!,
              textAlign: TextAlign.center,
              maxLines: 1,
              hint: "Page not found text ",
              label: "Page not found text ",
              value: "Page not found text ",
            ),
          )

          // Image.asset(
          //   imageLinkAssets!,
          //   width: widthImage,
          //   height: heightImage,
          //   fit: BoxFit.contain,
          // ),

          // const SizedBox(
          //   height: 18,
          // ),

          // Flexible(
          //     child: Text(
          //   text!,
          //   style: style,
          //   textAlign: TextAlign.center,
          //   overflow: TextOverflow.ellipsis,
          // )),
        ],
      ),
    );
  }
}
