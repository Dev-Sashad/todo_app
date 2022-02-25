import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/utils/colors.dart';

customYMargin(double value) {
  return SizedBox(height: value);
}

customXMargin(double value) {
  return SizedBox(width: value);
}

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      webPosition: "center",
      timeInSecForIosWeb: 5,
      backgroundColor: AppColors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

showErrorToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      webPosition: "center",
      webBgColor: "#e74c3c",
      timeInSecForIosWeb: 5,
      // backgroundColor: AppColors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

String capitalize(val) {
  return "${val[0].toUpperCase()}${val.substring(1)}";
}

formatDate(value) {
  final df = new DateFormat('dd-MM-yyyy');
  return df.format(DateTime.parse(value));
}

formatDateTime(value) {
  final df = new DateFormat('d MMMM, y hh:mm a');
  return df.format(DateTime.parse(value));
}

showErrorSnackbar(String title, String message, BuildContext context) {
  return Flushbar(
    backgroundColor: AppColors.red,
    title: title,
    icon: Icon(
      Icons.warning_amber_rounded,
      color: AppColors.white,
    ),
    flushbarPosition: FlushbarPosition.TOP,
    message: message,
    duration: Duration(seconds: 2),
  ).show(context);
}

showSuccessSnackbar(String title, String message, BuildContext context) {
  return Flushbar(
    backgroundColor: AppColors.green,
    title: title,
    icon: Icon(
      Icons.check_circle_outline_rounded,
      color: AppColors.white,
    ),
    flushbarPosition: FlushbarPosition.TOP,
    message: message,
    duration: Duration(seconds: 2),
  ).show(context);
}
