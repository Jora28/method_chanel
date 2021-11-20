import 'package:flutter/material.dart';
import 'package:metod_chanel/colors.dart';

class CustumButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;

  const CustumButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Container(
          child: Center(
              child: Text(
            buttonText,
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: TeleportColors.white),
          )),
        ));
  }
}
