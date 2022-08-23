
import 'package:http/http.dart' as http;

import '../model/product_response.dart';
import 'api_method.dart';
import 'api_urls.dart';

class ApiService {

  static Future<List<ProductsResponse>> getProducts() async {

    final List<ProductsResponse> _resmodel =[];

    List<Map<String, dynamic>>? mapResponse;

    mapResponse = await ApiMethod(true).get(ApiUrls.products, code: 200);

    if (mapResponse!.isNotEmpty) {

      for(int i=0;i<mapResponse.length-1;i++){
        _resmodel.add(ProductsResponse.fromJson(mapResponse[i]));
      }

    }
    return _resmodel;
  }


}
