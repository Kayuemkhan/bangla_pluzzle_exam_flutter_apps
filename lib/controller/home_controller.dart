import 'package:get/get.dart';

import '../data/api/api_service.dart';
import '../data/model/product_response.dart';

class HomeController extends GetxController{
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  List<ProductsResponse> profileResponse = [];

  @override
  void onInit() {
    super.onInit();
    getAllDataForDashBoard();
  }




  @override
  void onClose() {
  }
  Future<ProductsResponse?> getAllDataForDashBoard() async {
    _isLoading.value = true;

    await ApiService.getProducts(
    ).then((value) {
      _isLoading.value = false;

      profileResponse = value;

      print(profileResponse);
    });

    _isLoading.value = false;
    return null;
  }
}