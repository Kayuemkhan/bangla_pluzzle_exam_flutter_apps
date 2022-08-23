import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/details_product_controller.dart';
import '../../utils/custom_color.dart';
import '../../utils/size.dart';
import '../../utils/strings.dart';
import '../widgets/loading/loading_widget.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key}) : super(key: key);
  final controller = Get.put(DetailsProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.primaryBackgroundColor,
        appBar: AppBar(
          title: const Text(
            Strings.detailsScreen,
            style: TextStyle(color: CustomColor.whiteColor),
          ),
          backgroundColor: CustomColor.appBarColor,
          elevation: 0,
        ),
        body: Obx(
              () => controller.isLoading ?
          const Center(
              child:
              LoadingWidget()
          )
              : _bodyWidget(context),
        ));
  }

  Widget _bodyWidget(BuildContext context) {

    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*.4,
          width:MediaQuery.of(context).size.width ,
          child:
          Image.network(
              controller.image,
            fit: BoxFit.cover,
          ),
        ),
        addVerticalSpace(20),

        Text(
          "Name: ${controller.name}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
        addVerticalSpace(5),
        Text(
          "Category: ${controller.category}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0),
        ),
        addVerticalSpace(5),

        Row(
          children: [
            Text(
              "BDT: "+controller.rate,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.black,
                  fontSize: 16.0),
            ),
            addHorizontalSpace(10),
            Text(
              "BDT: "+controller.rate,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0),
            ),
          ],
        ),
        addVerticalSpace(5),
      ],
    );
  }
}
