import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 50,
                height: 50,
              ),
              Container(
                child: CircularProgressIndicator(
                  color: primaryColor,
                  strokeWidth: 2,
                ),
                width: 70,
                height: 70,
              )
            ],
          ),
        ),
      ),
    );
  }
}
