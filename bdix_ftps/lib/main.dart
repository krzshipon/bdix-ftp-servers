import 'package:flutter/material.dart';
import 'package:super_ui_kit/super_ui_kit.dart';
import 'app/routes/app_pages.dart';
import 'app/util/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initial Ui Config
  await setupUiConfig();

  runApp(
    GetMaterialApp(
      title: "BDIX FTPS",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: appThemeL,
      darkTheme: appThemeL,
      enableLog: true,
      //initialBinding: BindingsBuilder(() => initServices()),
      debugShowCheckedModeBanner: false,
    ),
  );
}

setupUiConfig() {
  AppConfig.loaderScale = 1.7;
}
