import 'package:almarry_ex/app/modules/setting_module/setting_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class settingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => settingController());
  }
}