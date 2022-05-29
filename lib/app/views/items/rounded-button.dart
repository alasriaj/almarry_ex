import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.buttonName,
    required this.function,
    this.wi = double.maxFinite,
    this.isrequest = false,
    this.isIcon = false,
    this.icon,
    required this.color,
  }) : super(key: key);

  final String? buttonName;
  final double? wi;
  final Function function;
  final bool isrequest;
  final bool isIcon;
  final IconData? icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => !isrequest ? function() : () {},
      // textColor: Colors.white,
      // minWidth: wi,
      // color: color,
      // height: 45,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      //
      style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 2,
          fixedSize: Size.fromHeight(45),
          onSurface: accentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: isrequest
          ? Center(
              child: progress(),
            )
          : Center(
              child: !isIcon
                  ? Text(buttonName!,
                      style: TextStyle(fontWeight: FontWeight.bold))
                  : Icon(
                      icon,
                      color: Colors.white,
                    )),
    );
  }
}
