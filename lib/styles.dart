import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metod_chanel/colors.dart';

double width = window.physicalSize.width / window.devicePixelRatio,
    height = window.physicalSize.height / window.devicePixelRatio;

class HW {
  static double getHeight(double height, BuildContext context) {
    return height * MediaQuery.of(context).size.height / 926;
  }

  static double getWidth(double width, BuildContext context) {
    return width * MediaQuery.of(context).size.width / 428;
  }
}

class Corners {
  static const double sm = 10;
  static const BorderRadius smBorder = BorderRadius.all(smRadius);
  static const Radius smRadius = Radius.circular(sm);
}

class Borders {
  static BorderSide border = BorderSide(color: TeleportColors.grey, width: 1.5);
  static BorderSide borderWith1 =
      BorderSide(color: TeleportColors.greyDark, width: 1);
  static BorderSide errorBorder = BorderSide(color: Colors.red, width: 1);
}

class Shadows {

   static List<BoxShadow> get cardBorder => const [
        BoxShadow(
          
            offset: Offset(0, 1),
            color: TeleportColors.grey,
            blurRadius: 2),
      
      ];
  
}
