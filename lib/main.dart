import 'package:Products/service/dio_service.dart';
import 'package:Products/service/encryptor_service.dart';
import 'package:Products/service/storage_service.dart';
import 'package:Products/utils/app_color.dart';
import 'package:Products/utils/constants.dart';
import 'package:Products/utils/localization/app_localizations_setup.dart';
import 'package:flutter/material.dart'
    show
        WidgetsFlutterBinding,
        StatelessWidget,
        ErrorWidget,
        FlutterErrorDetails,
        Scaffold,
        SizedBox,
        Column,
        MainAxisSize,
        Widget,
        Key,
        MaterialApp,
        BuildContext,
        ThemeMode,
        runApp,
        MainAxisAlignment,
        CrossAxisAlignment,
        Text,
        TextStyle,
        TextOverflow,
        TextAlign;
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:go_router/go_router.dart' show GoRouter, UrlPathStrategy;
import 'package:seo_renderer/seo_renderer.dart' show RobotDetector;

// import 'package:get_it/get_it.dart';
// import 'di/injection.dart';
import 'utils/router/router_generator.dart';

part 'app_initialize.dart';

void main() async {
  await _preInitializations();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RobotDetector(
      debug: false,
      child: MaterialApp.router(
        title: nameWebsite,
        debugShowCheckedModeBanner: false,
        routeInformationParser:
            RouteGenerator.getRouters().routeInformationParser,
        routerDelegate: RouteGenerator.getRouters().routerDelegate,
        routeInformationProvider:
            RouteGenerator.getRouters().routeInformationProvider,
        supportedLocales: AppLocalizationsSetup.supportedLocales,
        localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
        localeResolutionCallback:
            AppLocalizationsSetup.localeResolutionCallback,
        themeMode: ThemeMode.system,
        theme: DataHelper.currentTheme,
        locale: DataHelper.currentLanguage,
      ),
    );
  }
}
