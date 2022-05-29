import 'package:almarry_ex/app/modules/city_currancy_module/city_currancy_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class cityCurrancyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => cityCurrancyController());
  }
}