import 'package:almarry_ex/app/routes/app_pages.dart';
import "package:almarry_ex/constants.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:onesignal_flutter/onesignal_flutter.dart";

class loginController extends GetxController {
  var isLoading = false.obs;
  late BuildContext context;
  var formKey = GlobalKey<FormState>().obs;
  var phone = TextEditingController().obs;
  var pin = TextEditingController().obs;
  var code = TextEditingController().obs;
  var nodes = <FocusNode>[].obs;
  var canCheckBiometrics = false.obs;
  var canUseFinger = false.obs;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  @override
  void onInit() async {
    super.onInit();
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    await OneSignal.shared.getDeviceState().then((value) {
      stg.write("userId", value!.userId?.toString());
    });
    phone.value.text = stg.read('phone');
  }

  login() async {
    await OneSignal.shared.getDeviceState().then((value) {
      stg.write('userId', value!.userId?.toString());
    });
    if (formKey.value.currentState!.validate()) {
      formKey.value.currentState!.save();
      connect().then((value) async {
        if (value) {
          isLoading(true);
          users
              .where("phone", isEqualTo: phone.value.text.trim())
              .where("password", isEqualTo: pin.value.text.trim())
              .get()
              .then((value) {
            isLoading(false);
            users
                .doc(value.docs.first.id)
                .update({"userId": stg.read("userId")});
            stg.write('user', value.docs.first.data());
            stg.write('phone', phone.value.text.trim());
            Get.offNamed(Routes.HOME);
          }).catchError((c) {
            isLoading(false);
            message(c.toString());
          });
        } else {
          noconnect();
        }
      });
    }
  }
}
