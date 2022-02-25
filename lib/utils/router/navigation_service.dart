import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  pop() {
    return _navigationKey.currentState?.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateReplacementTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  void replaceBelow(Widget widget) {
    final anchor = (ModalRoute.of(_navigationKey.currentContext!) as PageRoute);
    final page = MaterialPageRoute(builder: (context) => widget);
    return _navigationKey.currentState!
        .replaceRouteBelow(anchorRoute: anchor, newRoute: page);
  }
}

pushScreen(Widget widget, {context}) async {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (c) => widget),
  );
}
