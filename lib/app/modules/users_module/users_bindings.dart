import 'package:almarry_ex/app/modules/users_module/users_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class usersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => usersController());
  }
}