import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput({
    Key? key,
    this.icon,
    @required this.hint,
    this.inputType,
    this.inputAction,
    this.textEditingController,
    this.ml = 9,
  }) : super(key: key);

  final IconData? icon;
  final String? hint;
  final int? ml;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          height: size.height * 0.07,
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: textEditingController,
                    maxLength: ml,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hint,
                      counterText: "",
                    ),
                    cursorColor: Colors.amber,
                    keyboardType: inputType,
                    textInputAction: inputAction,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
