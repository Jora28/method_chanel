import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metod_chanel/colors.dart';
import 'package:metod_chanel/styles.dart';

class CustumInput extends StatelessWidget {
  final GlobalKey? globalKey;
  final FocusNode? focusNode;
  final String hintText;
  final int? limit;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final Widget? prefix;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final bool? obscureText;
  final int? maxLines;
  final String? labelText;
  final String? helperText;
  CustumInput({
    this.globalKey,
    this.focusNode,
    this.helperText,
    this.textInputType,
    required this.hintText,
    this.suffixIcon,
    this.maxLines = 1,
    this.limit,
    this.labelText,
    required this.onSaved,
    required this.validator,
    required this.controller,
    this.onChanged,
    this.prefix,
    this.obscureText = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      key: globalKey,
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        maxLines: maxLines,
        keyboardType: textInputType,
        inputFormatters: [
          LengthLimitingTextInputFormatter(limit),
        ],
        focusNode: focusNode,
        cursorColor: TeleportColors.blueLight,
        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText!,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            helperText: helperText,
            helperStyle: Theme.of(context).textTheme.headline5,
            errorBorder: OutlineInputBorder(
                borderRadius: Corners.smBorder,
                borderSide: Borders.errorBorder),
            errorStyle: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.red),
            focusColor: TeleportColors.greyLight,
            fillColor: TeleportColors.greyLight,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: Corners.smBorder,
                borderSide: Borders.borderWith1),
            isDense: true,
            hintStyle: Theme.of(context).textTheme.bodyText1,
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
                borderRadius: Corners.smBorder,
                borderSide: Borders.borderWith1),
            enabledBorder: OutlineInputBorder(
                borderRadius: Corners.smBorder,
                borderSide: Borders.borderWith1),
            prefixIcon: prefix == null
                ? null
                : Container(
                    width: HW.getWidth(85, context),
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        prefix!,
                      ],
                    ),
                  ),
            suffixIcon: suffixIcon == null
                ? null
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      suffixIcon!,
                    ],
                  )),
      ),
    );
  }
}
