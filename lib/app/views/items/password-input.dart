import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
    this.hint,
    this.inputType,
    this.inputAction,
    this.textEditingController,
  }) : super(key: key);

  final String? hint;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.07,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
          ),
          cursorColor: Colors.amber,
          keyboardType: inputType,
          obscureText: true,
          textInputAction: inputAction,
        ),
      ),
    );
  }
}
