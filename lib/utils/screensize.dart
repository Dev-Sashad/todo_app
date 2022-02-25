import 'package:flutter/material.dart';

widthSizer(double value, BuildContext context, {figmaWidth: 414}) {
  // 414 is the default design screen width on figma
  return MediaQuery.of(context).size.width *
      (value / figmaWidth); // width size on figma
}

heightSizer(double value, BuildContext context, {figmaHeight: 896}) {
  // 896 is the default design screen height on figma
  return MediaQuery.of(context).size.height *
      (value / figmaHeight); // height size on figma
}

//Sanni height sizer
height(double value, BuildContext context) {
  return MediaQuery.of(context).size.height * (value / 100);
}

width(double value, BuildContext context) {
  return MediaQuery.of(context).size.width * (value / 100);
}
