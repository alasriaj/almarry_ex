import 'package:get/get.dart';

import '../../../constants.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class historyController extends GetxController {
  var slv = SalseMi(slasemi: []).obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    load();
  }

  load() {
    if (stg.read('sales') != null) {
      slv(SalseMi.fromJson(stg.read('sales')));
    }
  }
}
