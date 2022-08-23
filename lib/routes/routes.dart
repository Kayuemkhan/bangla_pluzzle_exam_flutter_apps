import 'package:flutter_sceleton/view/screens/details_product.dart';
import 'package:flutter_sceleton/view/screens/home_screen.dart';
import 'package:get/get.dart';


class Routes {
  static const String homeScreen = '/homeScreen';
  static const String detailsScreen = '/detailsScreen';



  static var list = [

    GetPage(
      name: homeScreen,
      page: () =>  HomeScreen(),
    ),
    GetPage(
      name: detailsScreen,
      page: () =>  DetailsScreen(),
    ),
  ];
}
