import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../locator.dart';
import 'dialog_models.dart';
import 'dialog_service.dart';

class ProgressManager extends StatefulWidget {
  final Widget? child;
  ProgressManager({Key? key, this.child}) : super(key: key);

  _ProgressManagerState createState() => _ProgressManagerState();
}

class _ProgressManagerState extends State<ProgressManager> {
  ProgressService _progressService = locator<ProgressService>();

  @override
  void initState() {
    super.initState();
    _progressService.registerProgressListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }

  void _showDialog(ProgressRequest request) {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        dismissable: false,
        animationDuration: Duration(milliseconds: 500),
        loadingWidget: Material(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: 60,
                  height: 60,
                ),
              ],
            ),
          ),
        ));
    // pr.show();
    progressDialog.show(); // show dialog
    //progressDialog.dismiss();
  }
}
