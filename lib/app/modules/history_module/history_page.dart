import 'package:almarry_ex/app/modules/history_module/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class historyPage extends GetView<historyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('سجل البيع والشراء')),
      body: GetBuilder<historyController>(
        builder: (st) {
          return st.slv.value.slasemi!.length > 0
              ? ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (x, i) => ListTile(
                        title: Text(st.slv.value.slasemi![i].type! +
                            ' ' +
                            st.slv.value.slasemi![i].amount.toString() +
                            ' ' +
                            st.slv.value.slasemi![i].currancy.toString() +
                            ' بـ' +
                            st.slv.value.slasemi![i].price.toString()),
                        trailing: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                st.slv.value.slasemi![i].city!,
                                style: Get.textTheme.button!
                                    .copyWith(fontSize: 16),
                              ),
                              Text(
                                '${DateFormat('yMMMMEEEEd', 'ar').format(DateTime.parse(st.slv.value.slasemi![i].date!))} ${DateFormat('jms', 'ar').format(DateTime.parse(st.slv.value.slasemi![i].date!))}',
                                style: Get.textTheme.button!
                                    .copyWith(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (x, i) => Divider(
                        height: 0,
                      ),
                  itemCount: st.slv.value.slasemi!.length)
              : Center(
                  child: Text(
                  'لا يوجد بيانات حتى الان',
                  style: Get.textTheme.headline6,
                ));
        },
        init: historyController(),
      ),
    );
  }
}
