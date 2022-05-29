import 'package:almarry_ex/app/modules/home_module/home_controller.dart';
import 'package:almarry_ex/app/routes/app_pages.dart';
import 'package:almarry_ex/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class homePage extends GetView<homeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/images/logow.png',
          ),
        ),
        title: Text('بورصة المري'.tr),
        centerTitle: false,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.HISTORY),
              icon: Icon(Icons.history)),
          IconButton(
              onPressed: () => Get.toNamed(Routes.SETTING),
              icon: Icon(Icons.settings)),
          IconButton(
              tooltip: 'تسجيل خروج'.tr,
              onPressed: () => logOut(context),
              icon: Icon(Icons.power_settings_new_rounded)),
        ],
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/images/back_bank_a.png',
              fit: BoxFit.cover,
              height: double.maxFinite,
            ),
          ),
          Obx(() {
            return SingleChildScrollView(
              controller: controller.scr.value,
              physics: BouncingScrollPhysics(),
              child: StreamBuilder<QuerySnapshot>(
                  stream: controller.salse
                      .where('date', isEqualTo: controller.dt.toString())
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Error(action: () {});
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }
                    if (snapshot.hasData) {
                      setDone();
                      print(controller.scr.value.position.maxScrollExtent);
                      // controller.scr.value
                      //     .jumpTo(controller.scr.value.position.maxScrollExtent);
                    }
                    controller.sls.clear();
                    for (var v in snapshot.data!.docs) {
                      var use =
                          Salse.fromJson(v.data()! as Map<String, dynamic>);
                      controller.sls.add(use);
                    }
                    controller.sls.sort((x, y) =>
                        DateTime.parse(x.id!).compareTo(DateTime.parse(y.id!)));
                    controller.sls.refresh();
                    controller.update();
                    return controller.sls.length > 0
                        ? ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.sls.length,
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 80, top: 10),
                            itemBuilder: (x, i) => Align(
                              alignment: controller.sls[i].user ==
                                      controller.user.value.name
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                width: 250,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onLongPress: () => controller
                                                  .sls[i].user ==
                                              controller.user.value.name
                                          ? controller
                                              .deleteSalse(controller.sls[i])
                                          : {},
                                      child: Card(
                                        elevation: 1.5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    flex: 20,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .sls[i].type!,
                                                          style: Get.textTheme
                                                              .headline6!
                                                              .copyWith(
                                                                  fontSize: 20),
                                                        ),
                                                        Text(
                                                          controller
                                                              .sls[i].city!,
                                                          style: Get
                                                              .textTheme.button!
                                                              .copyWith(
                                                                  fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 80,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .sls[i].amount
                                                              .toString(),
                                                          style: Get
                                                              .textTheme.button!
                                                              .copyWith(
                                                                  fontSize: 20),
                                                        ),
                                                        Text(
                                                          ToWord(
                                                                  controller
                                                                      .sls[i]
                                                                      .amount!,
                                                                  CurrencyInfo(
                                                                      0))
                                                              .ConvertToArabic(),
                                                          style: Get
                                                              .textTheme.button!
                                                              .copyWith(
                                                                  fontSize: 9),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: true,
                                                        ),
                                                        Text(
                                                          controller
                                                              .sls[i].currancy!,
                                                          style: Get
                                                              .textTheme.button!
                                                              .copyWith(
                                                                  fontSize: 20),
                                                        ),
                                                        Text(
                                                          'بـ${controller.sls[i].price!}',
                                                          style: Get.textTheme
                                                              .headline6!
                                                              .copyWith(
                                                                  fontSize: 22),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    controller.sls[i].user ==
                                                            controller
                                                                .user.value.name
                                                        ? SizedBox()
                                                        : Text(
                                                            controller
                                                                .sls[i].user!,
                                                            style: Get.textTheme
                                                                .button!
                                                                .copyWith(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                    Text(
                                                      '${DateFormat('yMMMMEEEEd', 'ar').format(DateTime.parse(controller.sls[i].id!))} ${DateFormat('jms', 'ar').format(DateTime.parse(controller.sls[i].id!))}',
                                                      style: Get
                                                          .textTheme.button!
                                                          .copyWith(
                                                              fontSize: 10),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Get.theme.cardColor
                                              .withOpacity(0.8)),
                                      child: Column(
                                        children: [
                                          ListView.separated(
                                              shrinkWrap: true,
                                              physics: ClampingScrollPhysics(),
                                              itemBuilder: (x, ii) => Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            controller
                                                                        .user
                                                                        .value
                                                                        .name ==
                                                                    controller
                                                                        .sls[i]
                                                                        .feadback![
                                                                            ii]
                                                                        .user
                                                                ? 'انت'
                                                                : controller
                                                                    .sls[i]
                                                                    .feadback![
                                                                        ii]
                                                                    .user!,
                                                            style: Get.textTheme
                                                                .button!
                                                                .copyWith(
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                          Text(
                                                            controller
                                                                .sls[i]
                                                                .feadback![ii]
                                                                .status!,
                                                            style: Get.textTheme
                                                                .button!
                                                                .copyWith(
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                        ],
                                                      ),
                                                      controller
                                                              .sls[i]
                                                              .feadback![ii]
                                                              .note!
                                                              .isNotEmpty
                                                          ? Text(
                                                              controller
                                                                  .sls[i]
                                                                  .feadback![ii]
                                                                  .note!,
                                                              style: Get
                                                                  .textTheme
                                                                  .button!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          9),
                                                            )
                                                          : SizedBox(),
                                                    ],
                                                  ),
                                              padding: EdgeInsets.all(8),
                                              separatorBuilder: (x, i) =>
                                                  Divider(
                                                    height: 0,
                                                  ),
                                              itemCount: controller
                                                  .sls[i].feadback!.length),
                                          controller.sls[i].user !=
                                                  controller.user.value.name
                                              ? controller.sls[i].feadback!
                                                          .where((e) =>
                                                              e.user ==
                                                              controller.user
                                                                  .value.name)
                                                          .length <=
                                                      0
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextButton.icon(
                                                          onPressed: () =>
                                                              controller
                                                                  .updateSales(
                                                                      1,
                                                                      controller
                                                                          .sls[i]),
                                                          icon:
                                                              Icon(Icons.check),
                                                          label: Text('موافق'),
                                                          style: ButtonStyle(
                                                              foregroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .green)),
                                                        ),
                                                        TextButton.icon(
                                                            onPressed: () =>
                                                                controller.updateSales(
                                                                    0,
                                                                    controller
                                                                            .sls[
                                                                        i]),
                                                            icon: Icon(
                                                                Icons.close),
                                                            label: Text('رفض'),
                                                            style: ButtonStyle(
                                                                foregroundColor:
                                                                    MaterialStateProperty
                                                                        .all(Colors
                                                                            .red))),
                                                      ],
                                                    )
                                                  : SizedBox()
                                              : controller.slv.value.slasemi!
                                                          .where((e) =>
                                                              e.id ==
                                                              controller
                                                                  .sls[i].id)
                                                          .length ==
                                                      0
                                                  ? TextButton.icon(
                                                      onPressed: () =>
                                                          controller.saveHist(
                                                              controller
                                                                  .sls[i]),
                                                      icon: Icon(Icons.save),
                                                      label:
                                                          Text('حفظ في سجلاتي'),
                                                    )
                                                  : SizedBox()
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox();
                  }),
            );
          }),
        ],
      ),
      primary: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addSale(),
        child: Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
