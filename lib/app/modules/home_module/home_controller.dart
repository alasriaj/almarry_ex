import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../constants.dart';

class homeController extends GetxController {
  final formKey = GlobalKey<FormState>().obs;
  final scr = ScrollController().obs;

  var dt = ''.obs;
  var user = User().obs;
  var amount = TextEditingController().obs;
  var price = TextEditingController().obs;
  var ci = TextEditingController().obs;
  var cu = TextEditingController().obs;
  var nodes = <FocusNode>[].obs;
  var fb = <String>[].obs;
  var sls = <Salse>[].obs;
  var city = Cites(currancy: []).obs;
  var slv = SalseMi(slasemi: []).obs;
  var curr = Currancy().obs;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  CollectionReference cites = FirebaseFirestore.instance.collection("cites");
  CollectionReference salse = FirebaseFirestore.instance.collection("salse");

  @override
  void onInit() {
    super.onInit();
    var t = DateTime.now();
    OneSignal.shared.clearOneSignalNotifications();
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {});
    dt(t.year.toString() + '-' + t.month.toString() + '-' + t.day.toString());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    load();
  }

  load() {
    if (stg.read('sales') != null) {
      slv(SalseMi.fromJson(stg.read('sales')));
    }
    slv.refresh();
    user(User.fromJson(stg.read('user') as Map<String, dynamic>));
  }

  deleteSalse(Salse sl) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: new Text("حذف العملية".tr,
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                  )),
              content: new Text(
                  'هل تريد تأكيد حذف'.tr + " ${sl.amount} ${sl.currancy}؟",
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                  )),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () => Get.back(),
                  child:
                      Text('لا'.tr, style: TextStyle(fontFamily: 'NotoSans')),
                ),
                CupertinoDialogAction(
                  child: Text('نعم'.tr,
                      style:
                          TextStyle(fontFamily: 'NotoSans', color: Colors.red)),
                  onPressed: () {
                    connect().then((value) async {
                      if (value) {
                        salse.where('id', isEqualTo: sl.id).get().then((value) {
                          salse
                              .doc(value.docs.first.id)
                              .delete()
                              .whenComplete(() {
                            Get.back();
                          });
                        });
                      } else {
                        noconnect();
                      }
                    });
                  },
                )
              ],
            ));
  }

  addSale() {
    city(Cites(currancy: []));
    curr(Currancy());
    amount.value.text = '';
    ci.value.text = '';
    cu.value.text = '';
    price.value.text = '';
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            color: Get.isDarkMode ? ThemeData.dark().cardColor : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'إضافة عملية جديدة'.tr,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  InkWell(
                      onTap: () => Get.back(),
                      highlightColor: grayColor,
                      child: Ink(
                        child: Text('إغلاق'.tr,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ))
                ],
              ),
              Obx(() {
                return Form(
                  key: formKey.value,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 10,
                              child: InkWell(
                                onTap: () => Get.bottomSheet(
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Get.isDarkMode
                                            ? ThemeData.dark().cardColor
                                            : Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                'إختر المدينة'.tr,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(),
                                              SizedBox(),
                                              SizedBox(),
                                              InkWell(
                                                  onTap: () => Get.back(),
                                                  highlightColor: grayColor,
                                                  child: Ink(
                                                    child: Text('إغلاق'.tr,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ))
                                            ],
                                          ),
                                          StreamBuilder<QuerySnapshot>(
                                              stream: cites.snapshots(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                if (snapshot.hasError) {
                                                  return Error(action: () {});
                                                }
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Loading();
                                                }
                                                return ListView(
                                                  shrinkWrap: true,
                                                  children: snapshot.data!.docs
                                                      .map(
                                                          (DocumentSnapshot e) {
                                                    var use = Cites.fromJson(
                                                        e.data() as Map<String,
                                                            dynamic>);
                                                    return ListTile(
                                                      title: Text(use.name!),
                                                      onTap: () {
                                                        city(use);
                                                        city.refresh();
                                                        ci.value.text =
                                                            city.value.name!;
                                                        Get.back();
                                                      },
                                                      subtitle: Text(
                                                        use.currancy!
                                                            .map((e) => e.name)
                                                            .toList()
                                                            .toString(),
                                                        style: Get
                                                            .textTheme.button,
                                                      ),
                                                    );
                                                  }).toList(),
                                                );
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                  elevation: 2,
                                  isScrollControlled: true,
                                ),
                                child: TextInputField(
                                  hint: 'المدينة'.tr,
                                  focusNode: nodes[0],
                                  textEditingController: ci.value,
                                  isMenu: true,
                                  isEnabe: false,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 10,
                              child: InkWell(
                                onTap: () => Get.bottomSheet(
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Get.isDarkMode
                                            ? ThemeData.dark().cardColor
                                            : Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                'إختر العملة'.tr,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(),
                                              SizedBox(),
                                              SizedBox(),
                                              InkWell(
                                                  onTap: () => Get.back(),
                                                  highlightColor: grayColor,
                                                  child: Ink(
                                                    child: Text('إغلاق'.tr,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ))
                                            ],
                                          ),
                                          city.value.currancy!.length > 0
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  itemBuilder: (x, i) =>
                                                      ListTile(
                                                    title: Text(city.value
                                                        .currancy![i].name!),
                                                    onTap: () {
                                                      curr(city
                                                          .value.currancy![i]);
                                                      curr.refresh();
                                                      cu.value.text = city.value
                                                          .currancy![i].name!;
                                                      Get.back();
                                                    },
                                                  ),
                                                  itemCount: city
                                                      .value.currancy!.length,
                                                )
                                              : Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Center(
                                                      child: Text(
                                                    'إختر المدينة أولاً',
                                                    style:
                                                        Get.textTheme.headline6,
                                                  )),
                                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                  elevation: 2,
                                  isScrollControlled: true,
                                ),
                                child: TextInputField(
                                  hint: 'العملة'.tr,
                                  focusNode: nodes[1],
                                  textEditingController: cu.value,
                                  inputAction: TextInputAction.next,
                                  inputType: TextInputType.text,
                                  isMenu: true,
                                  isEnabe: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                        curr.value.price != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('سعر الشراء:'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 10,
                                        child: Text(
                                          'اقل سعر: ${curr.value.price!.minP}',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Flexible(
                                        flex: 10,
                                        child: Text(
                                          'المتوسط: ${curr.value.price!.avargeP}',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Flexible(
                                        flex: 10,
                                        child: Text(
                                          'أعلى سعر: ${curr.value.price!.maxP}',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text('سعر البيع:'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 10,
                                        child: Text(
                                          'اقل سعر: ${curr.value.price!.minS}',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Flexible(
                                        flex: 10,
                                        child: Text(
                                          'المتوسط: ${curr.value.price!.avargeS}',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Flexible(
                                        flex: 10,
                                        child: Text(
                                          'أعلى سعر: ${curr.value.price!.maxS}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(),
                        Row(
                          children: [
                            Flexible(
                              flex: 10,
                              child: TextInputField(
                                hint: 'المبلغ'.tr,
                                focusNode: nodes[2],
                                textEditingController: amount.value,
                                inputAction: TextInputAction.next,
                                inputType: TextInputType.phone,
                                isValidator: false,
                                checkValidator: (String? fieldContent) {
                                  if (fieldContent!.isEmpty) {
                                    return 'الحقل مطلوب'.tr;
                                  } else if (double.parse(fieldContent) <= 0) {
                                    return 'ادخل قيمة صحيحة'.tr;
                                  } else
                                    return null;
                                },
                                tif: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[.0-9]')),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 10,
                              child: TextInputField(
                                hint: 'بسعر'.tr,
                                focusNode: nodes[3],
                                textEditingController: price.value,
                                inputAction: TextInputAction.next,
                                inputType: TextInputType.phone,
                                isValidator: false,
                                checkValidator: (String? fieldContent) {
                                  if (fieldContent!.isEmpty) {
                                    return 'الحقل مطلوب'.tr;
                                  } else if (double.parse(fieldContent) <= 0) {
                                    return 'ادخل قيمة صحيحة'.tr;
                                  } else
                                    return null;
                                },
                                tif: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[.0-9]')),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 10,
                              child: RoundedButton(
                                color: Colors.blue,
                                buttonName: 'بيع'.tr,
                                function: () => save(1),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 10,
                              child: RoundedButton(
                                color: Colors.deepOrangeAccent,
                                buttonName: 'شراء'.tr,
                                function: () => save(2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      elevation: 2,
      isScrollControlled: true,
    );
  }

  save(int i) {
    if (formKey.value.currentState!.validate()) {
      formKey.value.currentState!.save();
      connect().then((value) async {
        if (value) {
          salse.get().then((value) {
            var use = SalseA(
                id: DateTime.now().toString(),
                type: i == 1 ? 'بيع' : 'شراء',
                currancy: cu.value.text.trim(),
                amount: double.parse(amount.value.text.trim()),
                price: double.parse(price.value.text.trim()),
                user: user.value.name,
                city: ci.value.text.trim(),
                feadback: [],
                date: dt.value);

            salse
                .add(use.toJson())
                .whenComplete(() => Get.back())
                .catchError((er) {
              Get.snackbar('رسالة'.tr, er.toString(),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 5),
                  colorText: Colors.white);
            });

            NotificationService().sendPushNotifications(
                user.value.name!,
                ' يريد ' +
                    (i == 1 ? 'بيع' : 'شراء') +
                    ' ' +
                    amount.value.text.trim() +
                    ' ' +
                    use.currancy! +
                    ' في ' +
                    use.city! +
                    ' بـ ' +
                    use.price.toString());
          });
        } else {
          noconnect();
        }
      });
    }
  }

  updateSales(int i, Salse sl) {
    if (i == 1) {
      connect().then((value) async {
        if (value) {
          fb.clear();
          sl.feadback!
              .add(Feadback(note: '', status: 'موافق', user: user.value.name));
          for (var v in sl.feadback!.toList()) {
            fb.add(jsonEncode(v.toJson()));
          }
          salse.where('id', isEqualTo: sl.id).get().then((value) {
            var use = SalseA(
                id: sl.id,
                type: sl.type,
                currancy: sl.currancy,
                amount: sl.amount,
                price: sl.price,
                user: sl.user,
                city: sl.city,
                feadback: fb.toList(),
                date: sl.date);
            salse.doc(value.docs.first.id).set(use.toJson());
            users.where('name', isEqualTo: use.user).get().then((value) {
              var usev = User.fromJson(
                  value.docs.first.data() as Map<String, dynamic>);
              NotificationService().sendPushNotifications(
                  user.value.name!,
                  ' وافق على ' +
                      use.type! +
                      ' ' +
                      use.amount.toString() +
                      ' ' +
                      use.currancy! +
                      ' في ' +
                      use.city! +
                      ' بـ ' +
                      use.price.toString(),
                  userId: usev.userId);
            });
          });
        } else {
          noconnect();
        }
      });
    } else {
      cu.value.text = '';
      Get.bottomSheet(
        Container(
          decoration: BoxDecoration(
              color: Get.isDarkMode ? ThemeData.dark().cardColor : Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'رفض العملية'.tr,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(),
                    SizedBox(),
                    SizedBox(),
                    InkWell(
                        onTap: () => Get.back(),
                        highlightColor: grayColor,
                        child: Ink(
                          child: Text('إغلاق'.tr,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ))
                  ],
                ),
                Obx(() {
                  return Form(
                    key: formKey.value,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextInputField(
                            hint: 'ملاحظة'.tr,
                            focusNode: nodes[0],
                            textEditingController: amount.value,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.text,
                            isValidator: false,
                            checkValidator: (String? fieldContent) {
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RoundedButton(
                            color: primaryColor,
                            buttonName: 'إرسال'.tr,
                            function: () {
                              connect().then((value) async {
                                if (value) {
                                  fb.clear();
                                  sl.feadback!.add(Feadback(
                                      note: amount.value.text.trim(),
                                      status: 'رفض',
                                      user: user.value.name));
                                  for (var v in sl.feadback!.toList()) {
                                    fb.add(jsonEncode(v.toJson()));
                                  }
                                  salse
                                      .where('id', isEqualTo: sl.id)
                                      .get()
                                      .then((value) {
                                    var use = SalseA(
                                        id: sl.id,
                                        type: sl.type,
                                        currancy: sl.currancy,
                                        amount: sl.amount,
                                        price: sl.price,
                                        user: sl.user,
                                        city: sl.city,
                                        feadback: fb.toList(),
                                        date: sl.date);
                                    salse
                                        .doc(value.docs.first.id)
                                        .set(use.toJson())
                                        .then((value) => Get.back());
                                    users
                                        .where('name', isEqualTo: use.user)
                                        .get()
                                        .then((value) {
                                      var usev = User.fromJson(value.docs.first
                                          .data() as Map<String, dynamic>);
                                      NotificationService()
                                          .sendPushNotifications(
                                              user.value.name!,
                                              ' رفض ' +
                                                  use.type! +
                                                  ' ' +
                                                  use.amount.toString() +
                                                  ' ' +
                                                  use.currancy! +
                                                  ' في ' +
                                                  use.city! +
                                                  ' بـ ' +
                                                  use.price.toString(),
                                              userId: usev.userId);
                                    });
                                  });
                                } else {
                                  noconnect();
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        elevation: 2,
        isScrollControlled: true,
      );
    }
  }

  saveHist(Salse sl) {
    var smi = Slasemi(
        amount: sl.amount,
        city: sl.city,
        currancy: sl.currancy,
        date: DateTime.now().toString(),
        id: sl.id,
        price: sl.price,
        type: sl.type);
    if (slv.value.slasemi!.where((e) => e.id == smi.id).length <= 0) {
      slv.value.slasemi!.add(smi);
      stg.write('sales', slv.toJson());
      Get.snackbar('رسالة'.tr, 'تم إضافته بنجاح'.tr,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
          colorText: Colors.white);
    } else {
      Get.snackbar('رسالة'.tr, 'تم إضافته مسبقاً'.tr,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          colorText: Colors.white);
    }
    slv.refresh();
    load();
    update();
  }
}
