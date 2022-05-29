import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'loading.dart';

class NoConnect extends StatefulWidget {
  final Function action;

  const NoConnect({Key? key, required this.action}) : super(key: key);

  @override
  _NoConnectState createState() => _NoConnectState();
}

class _NoConnectState extends State<NoConnect> {
  bool ilo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/images/undraw_signal_searching_bhpc.png',
                height: 200,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'فشل الاتصال بالانترنت'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                'تأكد من إتصالك بشبكة الواي فاي او الجوال !'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.button,
              ),
              SizedBox(
                height: 10,
              ),
              TextButton.icon(
                label: Text('حاول مرة اخرى'.tr),
                icon: Icon(Icons.refresh_rounded),
                onPressed: () {
                  setState(() {
                    ilo = true;
                  });
                  widget.action().call();
                  Timer(Duration(seconds: 5), () {
                    setState(() {
                      ilo = false;
                    });
                  });
                },
              ),
              ilo ? Loading() : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
