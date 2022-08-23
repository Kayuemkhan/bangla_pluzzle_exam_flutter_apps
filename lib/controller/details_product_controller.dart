import 'package:get/get.dart';

class DetailsProductController extends GetxController{
  late String image, name, rate , category;


  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _isLoading.value = true;

    image = Get.arguments['image'];
    name = Get.arguments['name'];
    rate = Get.arguments['rate'];
    category = Get.arguments['category'];



    _isLoading.value = false;

  }

}