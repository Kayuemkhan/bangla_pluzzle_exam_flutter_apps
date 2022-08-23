import 'package:flutter/material.dart';
import 'package:flutter_sceleton/routes/routes.dart';
import 'package:flutter_sceleton/utils/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';



void main() async {
  await GetStorage.init(); // initializing getStorage
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) =>
          GetMaterialApp(

            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            title: Strings.appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.robotoTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            navigatorKey: Get.key,
            initialRoute: Routes.homeScreen,
            getPages: Routes.list,
          ),
    );
  }
}
