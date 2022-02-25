import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/screensize.dart';

class CustomTextFormField extends StatelessWidget {
  final double? height;
  final bool? expands;
  final double? borderRadius;
  final double? borderWidth;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final Color? fillColor;
  final bool? filled;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final bool? maxLengthEnforced;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final bool? readOnly, enabled;

  CustomTextFormField(
      {this.borderRadius = 10,
      this.borderWidth = 1,
      this.expands = false,
      this.height = 60,
      this.contentPaddingHorizontal = 12,
      this.contentPaddingVertical = 5,
      this.fillColor = AppColors.grey_light,
      this.filled = true,
      this.textInputType = TextInputType.text,
      this.enabled,
      this.readOnly,
      this.onChanged,
      this.maxLines = 1,
      this.maxLengthEnforced = false,
      this.validator,
      this.inputFormatters,
      this.controller,
      this.label,
      this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: heightSizer(5, context)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: EdgeInsets.only(bottom: heightSizer(5, context)),
              child: Text(label!,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black)),
            ),
          Container(
            height: height,
            child: TextFormField(
              readOnly: readOnly ?? false,
              enabled: enabled,
              controller: controller,
              style: TextStyle(color: AppColors.black, fontSize: 12),
              keyboardType: textInputType,
              onChanged: onChanged,
              maxLines: maxLines,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(borderRadius!)),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: widthSizer(contentPaddingHorizontal!, context),
                  vertical: heightSizer(contentPaddingVertical!, context),
                ),
                filled: filled,
                fillColor: fillColor,
                hintText: hint,
                hintStyle: TextStyle(color: AppColors.grey, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
