import 'package:almarry_ex/app/modules/city_currancy_module/city_currancy_controller.dart';
import 'package:almarry_ex/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class cityCurrancyPage extends GetView<cityCurrancyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('المدن والعملات')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addCity(),
        child: Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: Obx(() {
        return controller.isloading.isFalse
            ? Container(
                width: Get.mediaQuery.size.width,
                height: Get.mediaQuery.size.height,
                padding: EdgeInsets.all(7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 30,
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                                height: 40,
                                child: Center(child: Text('المدن/العملات'))),
                            ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.city.length,
                              separatorBuilder: (x, i) => SizedBox(
                                height: 5,
                              ),
                              itemBuilder: (x, i) => InkWell(
                                onTap: () {
                                  controller.cit(controller.city[i]);
                                  controller.currancy(
                                      controller.cit.value.currancy!.toList());
                                  controller.curr(controller.currancy.first);
                                  controller.price(controller.curr.value.price);
                                  controller.update();
                                },
                                onLongPress: () =>
                                    controller.updateCity(controller.city[i]),
                                child: Container(
                                    color: controller.cit.value.name ==
                                            controller.city[i].name!
                                        ? primaryColor
                                        : accentColor,
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        controller.city[i].name!,
                                        style: Get.textTheme.button!
                                            .copyWith(color: Colors.white),
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 70,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                height: 40,
                                child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.currancy.length,
                                  separatorBuilder: (x, i) => SizedBox(
                                    width: 5,
                                  ),
                                  itemBuilder: (x, i) => InkWell(
                                    onTap: () {
                                      controller.curr(controller.currancy[i]);
                                      controller
                                          .price(controller.curr.value.price);
                                      controller.update();
                                    },
                                    child: Container(
                                        color: controller.curr.value.name ==
                                                controller.currancy[i].name!
                                            ? primaryColor
                                            : accentColor,
                                        padding: EdgeInsets.all(7),
                                        child: Center(
                                          child: Text(
                                            controller.currancy[i].name!,
                                            style: Get.textTheme.button!
                                                .copyWith(color: Colors.white),
                                          ),
                                        )),
                                  ),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                'سعر الشراء:',
                                style: Get.textTheme.button,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'اقل سعر:',
                                        style: Get.textTheme.headline6,
                                      ),
                                      Text(
                                        controller.price.value.minP.toString(),
                                        style: Get.textTheme.headline6,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'المتوسط:',
                                        style: Get.textTheme.headline6,
                                      ),
                                      Text(
                                        controller.price.value.avargeP
                                            .toString(),
                                        style: Get.textTheme.headline6,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'اعلى سعر:',
                                        style: Get.textTheme.headline6,
                                      ),
                                      Text(
                                        controller.price.value.maxP.toString(),
                                        style: Get.textTheme.headline6,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                'سعر البيع:',
                                style: Get.textTheme.button,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'اقل سعر:',
                                        style: Get.textTheme.headline6,
                                      ),
                                      Text(
                                        controller.price.value.minS.toString(),
                                        style: Get.textTheme.headline6,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'المتوسط:',
                                        style: Get.textTheme.headline6,
                                      ),
                                      Text(
                                        controller.price.value.avargeS
                                            .toString(),
                                        style: Get.textTheme.headline6,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'اعلى سعر:',
                                        style: Get.textTheme.headline6,
                                      ),
                                      Text(
                                        controller.price.value.maxS.toString(),
                                        style: Get.textTheme.headline6,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Center(child: Loading());
      }),
    );
  }
}
