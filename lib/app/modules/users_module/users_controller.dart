import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class usersController extends GetxController {
  var formKey = GlobalKey<FormState>().obs;
  var name = TextEditingController().obs;
  var phone = TextEditingController().obs;
  var pin = TextEditingController().obs;
  var nodes = <FocusNode>[].obs;
  var isAdmin = false.obs;
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  @override
  void onInit() async {
    super.onInit();
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
  }

  pickContact() async {
    try {
      await [Permission.contacts].request().then((value) async {
        if (value.values.first.isGranted) {
          Contact? contact = await ContactsService.openDeviceContactPicker();
          name.value.text = contact!.displayName!;
          phone.value.text = contact.phones!.toList()[0].value!.trim();
        } else {
          Get.snackbar(
              'رسالة'.tr,
              'لا يمكننا المتابعة لعدم منحنا صلاحية الوصول لجهة الاتصال الخاصة بك'
                  .tr,
              backgroundColor: Colors.black45,
              colorText: Colors.white,
              duration: Duration(seconds: 5));
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  updateUser(User user, String iddc) {
    name.value.text = user.name!;
    phone.value.text = user.phone!;
    pin.value.text = user.password!;
    isAdmin.value = user.isAdmin!;
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
                    'تعديل المستخدم'.tr,
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
                        hint: 'الاسم'.tr,
                        focusNode: nodes[0],
                        textEditingController: name.value,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 19,
                            child: TextInputField(
                              hint: 'رقم الجوال'.tr,
                              focusNode: nodes[1],
                              textEditingController: phone.value,
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.phone,
                              isValidator: false,
                              checkValidator: (String? fieldContent) {
                                String sn = fieldContent!.substring(0, 2);
                                if (fieldContent.isEmpty) {
                                  return 'الحقل مطلوب'.tr;
                                } else if (phone.value.text.length > 9) {
                                  return 'يجب ان يكون طول الحقل اقل او يساوي 9 ارقام'
                                      .tr;
                                } else if (!fieldContent.isNum) {
                                  return 'يجب ان يحتوي على ارقام فقط'.tr;
                                } else if (!(fieldContent.startsWith('7') ||
                                    fieldContent.startsWith('0'))) {
                                  return 'يجب ان يبدأ بـ77 او 71 او 73 او 70 او 0'
                                      .tr;
                                } else if (fieldContent.startsWith('7')) {
                                  bool val = false;
                                  if (sn == '77' ||
                                      sn == '71' ||
                                      sn == '73' ||
                                      sn == '70') {
                                    val = true;
                                  } else
                                    val = false;
                                  return val
                                      ? null
                                      : 'يجب ان يبدأ بـ77 او 71 او 73  او 70'
                                          .tr;
                                }
                                return null;
                              },
                              tif: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 2,
                            child: IconButton(
                              icon: Icon(Icons.contacts_rounded),
                              onPressed: () => pickContact(),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 15,
                            child: TextInputField(
                              hint: 'كملة المرور'.tr,
                              focusNode: nodes[2],
                              textEditingController: pin.value,
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.text,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 10,
                            child: Row(
                              children: [
                                Obx(() {
                                  return Checkbox(
                                    value: isAdmin.value,
                                    activeColor: primaryColor,
                                    onChanged: (bool? value) {
                                      isAdmin(value);
                                    },
                                  );
                                }),
                                Text('مدير')
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
                              buttonName: 'حفظ'.tr,
                              function: () => edit(user, iddc),
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
                                            title: new Text("حذف مستخدم".tr,
                                                style: TextStyle(
                                                  fontFamily: 'NotoSans',
                                                )),
                                            content: new Text(
                                                'هل تريد تأكيد حذف'.tr +
                                                    " ${user.name}؟",
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
                                                onPressed: () => delete(iddc),
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

  addUser() {
    name.value.text = '';
    phone.value.text = '';
    pin.value.text = '';
    isAdmin.value = false;
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
                    'إضافة مستخدم جديد'.tr,
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
                        hint: 'الاسم'.tr,
                        focusNode: nodes[0],
                        textEditingController: name.value,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 19,
                            child: TextInputField(
                              hint: 'رقم الجوال'.tr,
                              focusNode: nodes[1],
                              textEditingController: phone.value,
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.phone,
                              isValidator: false,
                              checkValidator: (String? fieldContent) {
                                String sn = fieldContent!.substring(0, 2);
                                if (fieldContent.isEmpty) {
                                  return 'الحقل مطلوب'.tr;
                                } else if (phone.value.text.length > 9) {
                                  return 'يجب ان يكون طول الحقل اقل او يساوي 9 ارقام'
                                      .tr;
                                } else if (!fieldContent.isNum) {
                                  return 'يجب ان يحتوي على ارقام فقط'.tr;
                                } else if (!(fieldContent.startsWith('7') ||
                                    fieldContent.startsWith('0'))) {
                                  return 'يجب ان يبدأ بـ77 او 71 او 73 او 70 او 0'
                                      .tr;
                                } else if (fieldContent.startsWith('7')) {
                                  bool val = false;
                                  if (sn == '77' ||
                                      sn == '71' ||
                                      sn == '73' ||
                                      sn == '70') {
                                    val = true;
                                  } else
                                    val = false;
                                  return val
                                      ? null
                                      : 'يجب ان يبدأ بـ77 او 71 او 73  او 70'
                                          .tr;
                                }
                                return null;
                              },
                              tif: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 2,
                            child: IconButton(
                              icon: Icon(Icons.contacts_rounded),
                              onPressed: () => pickContact(),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 15,
                            child: TextInputField(
                              hint: 'كملة المرور'.tr,
                              focusNode: nodes[2],
                              textEditingController: pin.value,
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.text,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 10,
                            child: Row(
                              children: [
                                Obx(() {
                                  return Checkbox(
                                    value: isAdmin.value,
                                    activeColor: primaryColor,
                                    onChanged: (bool? value) {
                                      isAdmin(value);
                                    },
                                  );
                                }),
                                Text('مدير')
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
          users
              .where('name', isEqualTo: name.value.text.trim())
              .get()
              .then((value) {
            if (value.docs.length <= 0) {
              var use = User(
                  id: value.docs.length + 1,
                  isAdmin: isAdmin.value,
                  name: name.value.text.trim(),
                  password: pin.value.text.trim(),
                  phone: phone.value.text.trim(),
                  userId: '');
              Get.back();
              users.add(use.toJson()).whenComplete(() {
                Get.snackbar('رسالة'.tr, 'تم إضافة المستخدم بنجاح'.tr,
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 5),
                    colorText: Colors.white);
              });
            } else {
              message('هذا موجود من قبل');
            }
          });
        } else {
          noconnect();
        }
      });
    }
  }

  delete(String iddc) {
    connect().then((value) async {
      if (value) {
        users.get().then((value) {
          Get.back();
          users.doc(iddc).delete().whenComplete(() {
            Get.snackbar('رسالة'.tr, 'تم حذف المستخدم بنجاح'.tr,
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

  edit(User user, String iddc) {
    if (formKey.value.currentState!.validate()) {
      formKey.value.currentState!.save();
      connect().then((value) async {
        if (value) {
          users.get().then((value) {
            user.isAdmin = isAdmin.value;
            user.name = name.value.text.trim();
            user.password = pin.value.text.trim();
            user.phone = phone.value.text.trim();
            Get.back();
            users.doc(iddc).set(user.toJson()).whenComplete(() {
              Get.snackbar('رسالة'.tr, 'تم تحديث المستخدم بنجاح'.tr,
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
  }
}
