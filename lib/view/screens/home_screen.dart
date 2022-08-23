
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sceleton/controller/home_controller.dart';
import 'package:flutter_sceleton/routes/routes.dart';
import 'package:flutter_sceleton/utils/size.dart';
import 'package:flutter_sceleton/utils/strings.dart';
import 'package:get/get.dart';

import '../../utils/custom_color.dart';
import '../widgets/loading/loading_widget.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.primaryBackgroundColor,
        appBar: AppBar(
          title: const Text(
            Strings.homeScreenText,
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

   return ListView.builder(
       shrinkWrap: true,
       physics: const BouncingScrollPhysics(),
       scrollDirection: Axis.vertical,
       itemCount: controller.profileResponse.length,
       itemBuilder: (BuildContext context, int index){
        return

          InkWell(
            onTap: (){
                var thingOfItem ={
                  "image":controller.profileResponse[index].image,
                  "name":controller.profileResponse[index].title,
                  "rate":controller.profileResponse[index].price.toString(),
                  "category":controller.profileResponse[index].category,
                };

                Get.toNamed(Routes.detailsScreen,arguments: thingOfItem);
            },
            child: Card(

              child:
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child:
                    Container(
                      height: 120,
                      width: 120,
                      child: Image.network(
                          controller.profileResponse[index].image,

                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name: ${controller.profileResponse[index].title}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        Text(
                          "Category: ${controller.profileResponse[index].category}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12.0),
                        ),
                        Text(
                          "Rating: "+controller.profileResponse[index].rating.rate.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12.0),
                        ),
                        Text(
                          "Count: "+controller.profileResponse[index].rating.count.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12.0),
                        ),
                        Row(
                          children: [
                            Text(
                              "BDT: "+controller.profileResponse[index].rating.count.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black,
                                  fontSize: 12.0),
                            ),
                            addHorizontalSpace(10),
                            Text(
                              "BDT: "+controller.profileResponse[index].price.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0),
                            ),
                          ],
                        ),



                      ],
                    ),
                  )
                ],
              )
              ,
            ),
          );
       });
 }
}
