import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading.dart';

class Error extends StatefulWidget {
  final Function action;

  const Error({Key? key, required this.action}) : super(key: key);

  @override
  _ErrorState createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
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
                'assets/images/undraw_cancel_u1it.png',
                height: 150,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'حدث خطأ يرجى المحاولة مرة أخرى'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 10,
              ),
              TextButton.icon(
                label: Text('حاول مرة اخرى'.tr),
                icon: Icon(Icons.refresh_rounded),
                onPressed: () => widget.action(),
              ),
              ilo ? Loading() : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
