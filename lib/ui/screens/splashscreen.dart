import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/ui/screens/home/home.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/locator.dart';
import 'package:todo_app/utils/router/navigation_service.dart';
import 'package:todo_app/utils/router/route_names.dart';

import '../../utils/base_model.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
        onModelReady: (v) {
          v.navigationPage(context);
        },
        viewModelBuilder: () => SplashScreenViewModel(),
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Image.asset(
                        'assets/images/logo.png',
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        'Todo App',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      )
                    ]),
              ],
            ),
          );
        });
  }
}

class SplashScreenViewModel extends BaseModel {
  NavigationService _navigationService = locator<NavigationService>();
  void navigationPage(context) async {
    Future.delayed(Duration(seconds: 1)).then((value) async {
      _navigationService.navigateReplacementTo(MainHomeRoute);
    });
  }
}
