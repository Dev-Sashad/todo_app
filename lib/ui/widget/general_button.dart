import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/screensize.dart';

class GeneralButton extends StatelessWidget {
  final Widget? child;
  final Function? onPressed;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? splashColor;
  final String? buttonText;
  final Color? buttonTextColor;
  final bool? loading;
  GeneralButton(
      {Key? key,
      this.child,
      this.onPressed,
      this.loading = false,
      this.borderRadius = const BorderRadius.all(Radius.circular(10)),
      this.splashColor = AppColors.primaryColor,
      this.buttonText,
      this.buttonTextColor = AppColors.white,
      this.borderColor = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //padding: EdgeInsets.all(20),
        height: 50,
        width: width(100, context),
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius!,
            side: BorderSide(color: borderColor!),
          ),
          color: splashColor,
          onPressed: () {
            if (onPressed != null) {
              onPressed!();
            }
          },
          child: loading!
              ? CircularProgressIndicator(
                  color: AppColors.white,
                )
              : Text(
                  buttonText!,
                  style: TextStyle(
                      color: buttonTextColor, fontWeight: FontWeight.bold),
                ),
        ));
  }
}
