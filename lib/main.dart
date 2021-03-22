import 'package:animated_form/splashScreen.dart';
import 'package:animated_form/utils/baseWidget/base_widget.dart';
import 'package:animated_form/utils/constants/appColor.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await load();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  return runApp(
    DevicePreview(
      enabled: env['serverType'] == 'google.com' ? false : true,
      builder: (context) => GetMaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        defaultTransition: Transition.rightToLeft,
        debugShowCheckedModeBanner:
        env['serverType'] == 'google.com' ? true : false,
        theme: ThemeData(
            primaryColor: AppColor.textBlue,
            visualDensity: VisualDensity.comfortable,
            fontFamily: 'L',
            scaffoldBackgroundColor: Color(0xfff8f8f8),
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColor.textBlue,
              displayColor: AppColor.textBlue,
            ),
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(AppColor.orange)
                )
            ),
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                    color: AppColor.textBlue
                ),
                textTheme: Theme.of(context).primaryTextTheme.apply(
                  bodyColor: AppColor.textBlue,
                  displayColor: AppColor.textBlue,
                ),
                titleTextStyle: TextStyle(
                  fontSize: 18,
                  fontFamily: 'R',
                ),
                centerTitle: true,
                backgroundColor: Colors.white
            )
        ),
        home: BaseWidget(builder: (context, size) => SplashScreen()),
      ),
    ),
  );
}