import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoData extends StatefulWidget {
  const NoData({
    Key? key,
  }) : super(key: key);

  @override
  _NoDataState createState() => _NoDataState();
}

class _NoDataState extends State<NoData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? ThemeData.dark().cardColor : Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/images/undraw_No_data_re_kwbl.png',
                height: 200,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'لايوجد بيانات'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
