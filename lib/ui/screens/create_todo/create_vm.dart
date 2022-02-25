import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/model/error_model.dart';
import 'package:todo_app/core/model/todo_model.dart';
import 'package:todo_app/ui/screens/home/home.dart';
import 'package:todo_app/utils/base_model.dart';
import 'package:todo_app/utils/enum.dart';
import 'package:todo_app/utils/graph_ql/key.dart';
import 'package:todo_app/utils/helpers.dart';

import '../../../core/services/todo_service.dart';
import '../../../utils/locator.dart';
import '../../../utils/router/navigation_service.dart';

class CreateTaskVm extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final TodoServices _todoServices = locator<TodoServices>();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  initField(Tasks value) {
    title.text = value.title!;
    desc.text = value.description!;
    notifyListeners();
  }

  LoadingState _busy = LoadingState.IDLE;
  LoadingState get busy => _busy;

  void setBusy(LoadingState value) {
    _busy = value;
    notifyListeners();
  }

  pop() {
    _navigationService.pop();
  }

  reload(BuildContext context) {
    final anchor = ModalRoute.of(context) as Route;
    final page = MaterialPageRoute(builder: (context) => HomePage());
    Navigator.replaceRouteBelow(context, anchorRoute: anchor, newRoute: page);
    notifyListeners();
    _navigationService.pop();
  }

  delete(Tasks value, context) async {
    setBusy(LoadingState.LOADING);
    var connectivityResult = await (Connectivity().checkConnectivity());
    var isConnected = connectivityResult != ConnectivityResult.none;
    try {
      if (!isConnected) {
        setBusy(LoadingState.IDLE);
        showErrorSnackbar(
            "Connection Error", "Kindly check internet connection", context);
      } else {
        var payload = {"id": value.id};
        var result = await _todoServices.deleteData(payload);
        if (result is ErrorModel) {
          setBusy(LoadingState.IDLE);
          print(result.error);
          showErrorSnackbar('Error', result.error, context);
        } else {
          setBusy(LoadingState.DONE);
          reload(context);
          showSuccessSnackbar('Success', 'Task successfully deleted', context);
        }
      }
    } catch (e) {
      setBusy(LoadingState.IDLE);
      showErrorSnackbar('Error', 'An error occured. Try again later', context);
    }
  }

  updateTask(Tasks value, context) async {
    setBusy(LoadingState.LOADING);
    var connectivityResult = await (Connectivity().checkConnectivity());
    var isConnected = connectivityResult != ConnectivityResult.none;
    try {
      if (!isConnected) {
        setBusy(LoadingState.IDLE);
        showErrorSnackbar(
            "Connection Error", "Kindly check internet connection", context);
      } else {
        var payload = {
          "id": value.id,
          "payload": {
            "isCompleted": value.isCompleted,
            "title": title.text.trim(),
            "description": desc.text.trim()
          }
        };
        var result = await _todoServices.updateData(payload);
        if (result is ErrorModel) {
          setBusy(LoadingState.IDLE);
          print(result.error);
          showErrorSnackbar('Error', result.error, context);
        } else {
          setBusy(LoadingState.DONE);
          reload(context);
          showSuccessSnackbar('Success', 'Task successfully updated', context);
        }
      }
    } catch (e) {
      setBusy(LoadingState.IDLE);
      showErrorSnackbar('Error', 'An error occured. Try again later', context);
    }
  }

  postTask(Tasks value, context) async {
    setBusy(LoadingState.LOADING);
    var connectivityResult = await (Connectivity().checkConnectivity());
    var isConnected = connectivityResult != ConnectivityResult.none;
    try {
      if (!isConnected) {
        setBusy(LoadingState.IDLE);
        showErrorSnackbar(
            "Connection Error", "Kindly check internet connection", context);
      } else {
        var payload = {
          "developer_id": DevKeys.devId,
          "title": title.text.trim(),
          "description": desc.text.trim()
        };
        print(payload);
        var result = await _todoServices.postData(payload);
        if (result is ErrorModel) {
          setBusy(LoadingState.IDLE);
          print(result.error);
          showErrorSnackbar('Error', result.error, context);
        } else {
          setBusy(LoadingState.DONE);
          reload(context);
          showSuccessSnackbar('Success', 'Task successfully created', context);
        }
      }
    } catch (e) {
      setBusy(LoadingState.IDLE);
      showErrorSnackbar('Error', 'An error occured. Try again later', context);
    }
  }
}
