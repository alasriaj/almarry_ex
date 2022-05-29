import 'package:almarry_ex/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    this.hint,
    this.inputType,
    this.inputAction,
    this.textEditingController,
    this.isMenu = false,
    this.isEnabe = true,
    this.focusNode,
    this.tif,
    this.max,
    this.obscureText = false,
    this.isValidator = false,
    this.checkValidator,
  }) : super(key: key);

  final String? hint;
  final TextInputType? inputType;
  final List<TextInputFormatter>? tif;
  final TextInputAction? inputAction;
  final bool isMenu;
  final bool isEnabe;
  final bool obscureText;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final int? max;
  final bool isValidator;
  final String? Function(String?)? checkValidator;

  String? checkFieldEmpty(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'الحقل مطلوب'.tr;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: inputType,
      inputFormatters: tif,
      textInputAction: inputAction,
      enabled: isEnabe,
      maxLength: max ?? null,
      obscureText: obscureText,
      focusNode: focusNode,
      autocorrect: true,
      obscuringCharacter: "*",
      validator: isValidator ? checkValidator : checkFieldEmpty,
      decoration: InputDecoration(
        labelText: hint!,
        alignLabelWithHint: true,
        enabled: isEnabe,
        errorStyle: TextStyle(
          color: Theme.of(context).errorColor,
        ),
        floatingLabelStyle: TextStyle(color: primaryColor),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        suffix: isMenu == true
            ? Icon(
                Icons.keyboard_arrow_down_rounded,
              )
            : GestureDetector(
                child: Icon(Icons.highlight_remove_rounded),
                onTap: () => textEditingController!.clear(),
              ),
      ),
    );
  }
}
