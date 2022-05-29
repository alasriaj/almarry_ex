import 'package:almarry_ex/app/modules/history_module/history_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class historyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => historyController());
  }
}