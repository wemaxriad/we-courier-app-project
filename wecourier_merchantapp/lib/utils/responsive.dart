import 'package:flutter/material.dart';

responsiveHeight(BuildContext context, double value) {
  return MediaQuery.sizeOf(context).height * value;
}

responsiveWidth(BuildContext context, double value) {
  return MediaQuery.sizeOf(context).width * value;
}

double twentyPixelWidth(BuildContext context) {
  return responsiveWidth(context, 0.04875);
}

double twentyPixelheight(BuildContext context) {
  return responsiveHeight(context, 0.02308);
}

Widget verticalSpace(double height) {
  return SizedBox(height: height);
}

Widget horizontalSpace(double width) {
  return SizedBox(width: width);
}
