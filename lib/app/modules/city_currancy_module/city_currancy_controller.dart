import 'dart:convert';

import 'package:almarry_ex/app/data/models/Cites.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class cityCurrancyController extends GetxController {
  var formKey = GlobalKey<FormState>().obs;
  var formKeyc = GlobalKey<FormState>().obs;
  var name = TextEditingController().obs;
  var namec = TextEditingController().obs;
  var mxS = TextEditingController().obs;
  var mxP = TextEditingController().obs;
  var mnS = TextEditingController().obs;
  var mnP = TextEditingController().obs;
  var avS = TextEditingController().obs;
  var avP = TextEditingController().obs;
  var nodes = <FocusNode>[].obs;
  var isloading = false.obs;
  var city = <Cites>[].obs;
  var cit = Cites().obs;
  var currAdd = <Currancy>[].obs;
  var currAddA = <String>[].obs;
  var currancy = <Currancy>[].obs;
  var curr = Currancy().obs;
  var price = Price().obs;
  CollectionReference cites = FirebaseFirestore.instance.collection("cites");

  @override
  void onInit() async {
    super.onInit();
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    load();
  }

  load() {
    isloading(true);
    city.clear();
    cites.get().then((value) {
      for (var e in value.docs) {
        city.add(Cites.fromJson(e.data() as Map<String, dynamic>));
      }
      if (city.length > 0) {
        cit(city.first);
        currancy(cit.value.currancy!.toList());
        curr(currancy.first);
        price(cit.value.currancy!.first.price);
      }
    }).whenComplete(() => isloading(false));

    price.refresh();
    currancy.refresh();
    city.refresh();
    update();
  }

  updateCity(Cites cites) {
    name.value.text = cites.name!;
    currAdd.clear();
    currAdd(cites.currancy!.toList());
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
                    'تعديل مدينة'.tr,
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
              Form(
                key: formKey.value,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TextInputField(
                        hint: 'اسم المدينة'.tr,
                        focusNode: nodes[0],
                        textEditingController: name.value,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(flex: 15, child: Text('العملات')),
                          Flexible(
                            flex: 75,
                            child: Obx(() {
                              return Container(
                                  height: 40,
                                  child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: currAdd.length,
                                    separatorBuilder: (x, i) => SizedBox(
                                      width: 5,
                                    ),
                                    itemBuilder: (x, i) => InkWell(
                                      onTap: () => updateCu(i),
                                      child: Container(
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(35)),
                                          child: Center(
                                            child: Text(
                                              currAdd[i].name!,
                                              style: Get.textTheme.button!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          )),
                                    ),
                                  ));
                            }),
                          ),
                          Flexible(
                            flex: 10,
                            child: IconButton(
                                onPressed: () => addCu(),
                                icon: Icon(
                                  Icons.add_rounded,
                                  size: 25,
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 8,
                            child: RoundedButton(
                              color: primaryColor,
                              buttonName: 'تحديث'.tr,
                              function: () => edit(cites),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 2,
                            child: RoundedButton(
                                isIcon: true,
                                color: Colors.red,
                                icon: Icons.delete_outline_rounded,
                                function: () {
                                  Get.back();
                                  showDialog(
                                      context: Get.context!,
                                      builder: (BuildContext context) =>
                                          CupertinoAlertDialog(
                                            title: new Text("حذف مدينة".tr,
                                                style: TextStyle(
                                                  fontFamily: 'NotoSans',
                                                )),
                                            content: new Text(
                                                'هل تريد تأكيد حذف'.tr +
                                                    " ${cites.name}؟",
                                                style: TextStyle(
                                                  fontFamily: 'NotoSans',
                                                )),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                isDefaultAction: true,
                                                onPressed: () => Get.back(),
                                                child: Text('لا'.tr,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'NotoSans')),
                                              ),
                                              CupertinoDialogAction(
                                                child: Text('نعم'.tr,
                                                    style: TextStyle(
                                                        fontFamily: 'NotoSans',
                                                        color: Colors.red)),
                                                onPressed: () => delete(cites),
                                              )
                                            ],
                                          ));
                                }),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      elevation: 2,
      isScrollControlled: true,
    );
  }

  addCity() {
    name.value.text = '';
    currAdd.clear();
    currAddA.clear();
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
                    'إضافة مدينة جديدة'.tr,
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
              Form(
                key: formKey.value,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TextInputField(
                        hint: 'اسم المدينة'.tr,
                        focusNode: nodes[0],
                        textEditingController: name.value,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(flex: 15, child: Text('العملات')),
                          Flexible(
                            flex: 75,
                            child: Obx(() {
                              return Container(
                                  height: 40,
                                  child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: currAdd.length,
                                    separatorBuilder: (x, i) => SizedBox(
                                      width: 5,
                                    ),
                                    itemBuilder: (x, i) => InkWell(
                                      onTap: () => updateCu(i),
                                      child: Container(
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(35)),
                                          child: Center(
                                            child: Text(
                                              currAdd[i].name!,
                                              style: Get.textTheme.button!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          )),
                                    ),
                                  ));
                            }),
                          ),
                          Flexible(
                            flex: 10,
                            child: IconButton(
                                onPressed: () => addCu(),
                                icon: Icon(
                                  Icons.add_rounded,
                                  size: 25,
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                        color: primaryColor,
                        buttonName: 'حفظ'.tr,
                        function: () => save(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      elevation: 2,
      isScrollControlled: true,
    );
  }

  save() {
    if (formKey.value.currentState!.validate()) {
      formKey.value.currentState!.save();
      connect().then((value) async {
        if (value) {
          if (currAdd.length > 0) {
            cites
                .where('name', isEqualTo: name.value.text.trim())
                .get()
                .then((value) {
              if (value.docs.length <= 0) {
                var use = CitesA(
                    name: name.value.text.trim(), currancy: currAddA.toList());
                Get.back();
                cites.add(use.toJson()).whenComplete(() {
                  Get.snackbar(
                      'رسالة'.tr, 'تم إضافة المدينة مع العملات بنجاح'.tr,
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                      colorText: Colors.white);
                  load();
                });
              } else {
                message('هذا موجود من قبل');
              }
            });
          } else {
            message('يجب ان تضيف عملات');
          }
        } else {
          noconnect();
        }
      });
    }
  }

  svaCu() {
    if (formKeyc.value.currentState!.validate()) {
      formKeyc.value.currentState!.save();
      connect().then((value) async {
        if (value) {
          var vc = Currancy(
              name: namec.value.text.trim(),
              price: Price(
                avargeP: double.parse(avP.value.text.trim()),
                avargeS: double.parse(avS.value.text.trim()),
                maxP: double.parse(mxP.value.text.trim()),
                maxS: double.parse(mxS.value.text.trim()),
                minP: double.parse(mnP.value.text.trim()),
                minS: double.parse(mnS.value.text.trim()),
              ));
          currAdd.add(vc);
          currAddA.add(jsonEncode(vc.toJson()));
          currAdd.refresh();
          update();
          Get.back();
        } else {
          noconnect();
        }
      });
    }
  }

  edtCu(int i) {
    if (formKeyc.value.currentState!.validate()) {
      formKeyc.value.currentState!.save();
      connect().then((value) async {
        if (value) {
          var vc = Currancy(
              name: namec.value.text.trim(),
              price: Price(
                avargeP: double.parse(avP.value.text.trim()),
                avargeS: double.parse(avS.value.text.trim()),
                maxP: double.parse(mxP.value.text.trim()),
                maxS: double.parse(mxS.value.text.trim()),
                minP: double.parse(mnP.value.text.trim()),
                minS: double.parse(mnS.value.text.trim()),
              ));
          currAdd[i] = vc;
          currAddA[i] = jsonEncode(vc.toJson());
          currAdd.refresh();
          currAddA.refresh();
          update();
          Get.back();
        } else {
          noconnect();
        }
      });
    }
  }

  delete(Cites cite) {
    connect().then((value) async {
      if (value) {
        cites.where('name', isEqualTo: cite.name).get().then((value) {
          Get.back();
          load();
          cites.doc(value.docs.first.id).delete().whenComplete(() {
            Get.snackbar('رسالة'.tr, 'تم حذف المدينة بنجاح'.tr,
                backgroundColor: Colors.green,
                duration: Duration(seconds: 5),
                colorText: Colors.white);
          });
        });
      } else {
        noconnect();
      }
    });
  }

  edit(Cites cite) {
    if (formKey.value.currentState!.validate()) {
      formKey.value.currentState!.save();
      connect().then((value) async {
        if (value) {
          if (currAdd.length > 0) {
            currAddA.clear();
            for (var v in currAdd.toList()) {
              currAddA.add(jsonEncode(v.toJson()));
            }
            cites.where('name', isEqualTo: cite.name).get().then((value) {
              var use = CitesA(
                  name: name.value.text.trim(), currancy: currAddA.toList());
              print(use.toJson());
              Get.back();
              cites.doc(value.docs.first.id).set(use.toJson()).whenComplete(() {
                Get.snackbar('رسالة'.tr, 'تم تحديث المدينة مع العملات بنجاح'.tr,
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 5),
                    colorText: Colors.white);
                load();
              });
            });
          } else {
            message('يجب ان تضيف عملات');
          }
        } else {
          noconnect();
        }
      });
    }
  }

  addCu() {
    namec.value.text = '';
    mnP.value.text = '';
    mnS.value.text = '';
    mxP.value.text = '';
    mxS.value.text = '';
    avP.value.text = '';
    avS.value.text = '';
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
                    'إضافة عملة'.tr,
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
              Form(
                key: formKeyc.value,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInputField(
                        hint: 'اسم العملة'.tr,
                        focusNode: nodes[8],
                        textEditingController: namec.value,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                      ),
                      Text('سعر الشراء:'),
                      Row(
                        children: [
                          Flexible(
                            flex: 10,
                            child: TextInputField(
                              hint: 'اقل سعر'.tr,
                              focusNode: nodes[1],
                              textEditingController: mnS.value,
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
                            width: 7,
                          ),
                          Flexible(
                            flex: 10,
                            child: TextInputField(
                              hint: 'المتوسط'.tr,
                              focusNode: nodes[2],
                              textEditingController: avS.value,
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
                            width: 7,
                          ),
                          Flexible(
                            flex: 10,
                            child: TextInputField(
                              hint: 'أعلى سعر'.tr,
                              focusNode: nodes[3],
                              textEditingController: mxS.value,
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
                      Text('سعر البيع:'),
                      Row(
                        children: [
                          Flexible(
                            flex: 10,
                            child: TextInputField(
                              hint: 'اقل سعر'.tr,
                              focusNode: nodes[4],
                              textEditingController: mnP.value,
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
                            width: 7,
                          ),
                          Flexible(
                            flex: 10,
                            child: TextInputField(
                              hint: 'المتوسط'.tr,
                              focusNode: nodes[5],
                              textEditingController: avP.value,
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
                            width: 7,
                          ),
                          Flexible(
                            flex: 10,
                            child: TextInputField(
                              hint: 'أعلى سعر'.tr,
                              focusNode: nodes[6],
                              textEditingController: mxP.value,
                              inputAction: TextInputAction.done,
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
                      RoundedButton(
                        color: primaryColor,
                        buttonName: 'إضافة'.tr,
                        function: () => svaCu(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      elevation: 2,
      isScrollControlled: true,
    );
  }

  updateCu(int i) {
    namec.value.text = currAdd[i].name!;
    mnP.value.text = currAdd[i].price!.minP.toString();
    mnS.value.text = currAdd[i].price!.minS.toString();
    mxP.value.text = currAdd[i].price!.maxP.toString();
    mxS.value.text = currAdd[i].price!.maxS.toString();
    avP.value.text = currAdd[i].price!.avargeP.toString();
    avS.value.text = currAdd[i].price!.avargeS.toString();
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
                    'تحديث عملة'.tr,
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
              Form(
                key: formKeyc.value,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInputField(
                        hint: 'اسم العملة'.tr,
                        focusNode: nodes[8],
                        textEditingController: namec.value,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                      ),
                      Text('سعر الشراء:'),
                      Row(
                        children: [
                          Flexible(
                            flex: 10,
                            child: TextInputField(
                              hint: 'اقل سعر'.tr,
                              focusNode: nodes[1],
                              textEditingController: mnS.value,
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
                            width: 7,
                          ),
                          Flexible(
                            flex: 10,
                            child: TextInputField(
                              hint: 'المتوسط'.tr,
                              focusNode: nodes[2],
                              textEditingController: avS.value,
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
                            width: 7,
                          ),
                          Flexible(
                            flex: 10,
                            child: TextInputField(
                              hint: 'أعلى سعر'.tr,
                              focusNode: nodes[3],
                              textEditingController: mxS.value,
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
                      Text('سعر البيع:'),
                      Row(
                        children: [
                          Flexible(
                            flex: 10,
                            child: TextInputField(
                              hint: 'اقل سعر'.tr,
                              focusNode: nodes[4],
                              textEditingController: mnP.value,
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
                            width: 7,
                          ),
                          Flexible(
                            flex: 10,
                            child: TextInputField(
                              hint: 'المتوسط'.tr,
                              focusNode: nodes[5],
                              textEditingController: avP.value,
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
                            width: 7,
                          ),
                          Flexible(
                            flex: 10,
                            child: TextInputField(
                              hint: 'أعلى سعر'.tr,
                              focusNode: nodes[6],
                              textEditingController: mxP.value,
                              inputAction: TextInputAction.done,
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
                        children: [
                          Flexible(
                            flex: 8,
                            child: RoundedButton(
                              color: primaryColor,
                              buttonName: 'تحديث'.tr,
                              function: () => edtCu(i),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 2,
                            child: RoundedButton(
                                isIcon: true,
                                color: Colors.red,
                                icon: Icons.delete_outline_rounded,
                                function: () {
                                  Get.back();
                                  showDialog(
                                      context: Get.context!,
                                      builder: (BuildContext context) =>
                                          CupertinoAlertDialog(
                                            title: new Text("حذف العملة".tr,
                                                style: TextStyle(
                                                  fontFamily: 'NotoSans',
                                                )),
                                            content: new Text(
                                                'هل تريد تأكيد حذف'.tr +
                                                    " ${currAdd[i].name}؟",
                                                style: TextStyle(
                                                  fontFamily: 'NotoSans',
                                                )),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                isDefaultAction: true,
                                                onPressed: () => Get.back(),
                                                child: Text('لا'.tr,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'NotoSans')),
                                              ),
                                              CupertinoDialogAction(
                                                child: Text('نعم'.tr,
                                                    style: TextStyle(
                                                        fontFamily: 'NotoSans',
                                                        color: Colors.red)),
                                                onPressed: () {
                                                  currAdd.removeAt(i);
                                                  update();
                                                  Get.back();
                                                },
                                              )
                                            ],
                                          ));
                                }),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      elevation: 2,
      isScrollControlled: true,
    );
  }
}
