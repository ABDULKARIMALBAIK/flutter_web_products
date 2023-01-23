part of 'main.dart';

Future _preInitializations() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ResponsiveSizer.setMaxWidth(inputWidth);
  // ResponsiveSizer.setMaxHeight(inputHeight);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

  _overrideErrorWidget();

  //Injectable Method
  // await configureInjection(Env.prod);

  // StorageService storageService = GetIt.instance.get<StorageService>();
  StorageService storageService = StorageService();
  DioService dioService = DioService();
  EncryptorService encryptorService = EncryptorService();
  await storageService.initDatabase();

  DataHelper.storageService = storageService;
  DataHelper.dioService = dioService;
  DataHelper.encryptorService = encryptorService;
  DataHelper.currentLanguage = storageService.languageStorage.getLanguage();
  DataHelper.currentTheme = storageService.themeStorage.getTheme();

  DataHelper.isDark = storageService.themeStorage.darkMode();
}

void _overrideErrorWidget() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      body: SizedBox(
        width: 1000,
        height: 1000,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Something went wrong , please restart the Website",
              style: TextStyle(
                color: AppColor().primaryColorLight(),
                fontSize: 18,
              ),
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  };
}
