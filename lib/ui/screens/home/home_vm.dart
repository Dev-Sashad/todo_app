import 'package:connectivity/connectivity.dart';
import 'package:todo_app/core/model/todo_model.dart';
import 'package:todo_app/ui/screens/create_todo/create.dart';
import 'package:todo_app/utils/base_model.dart';
import 'package:todo_app/utils/router/navigation_service.dart';

import '../../../core/model/error_model.dart';
import '../../../core/services/todo_service.dart';
import '../../../utils/enum.dart';
import '../../../utils/graph_ql/key.dart';
import '../../../utils/helpers.dart';
import '../../../utils/locator.dart';

class HomeVm extends BaseModel {
  final TodoServices _todoServices = locator<TodoServices>();

  List<Tasks> _tasks = [];
  List<Tasks> get tasks => _tasks;
  LoadingState _busy = LoadingState.IDLE;
  LoadingState get busy => _busy;

  void setBusy(LoadingState value) {
    _busy = value;
    notifyListeners();
  }

  Future getdata(context) async {
    setBusy(LoadingState.LOADING);
    var connectivityResult = await (Connectivity().checkConnectivity());
    var isConnected = connectivityResult != ConnectivityResult.none;
    try {
      if (!isConnected) {
        setBusy(LoadingState.IDLE);
        showErrorSnackbar(
            "Connection Error", "Kindly check internet connection", context);
      } else {
        var payload = {"developer_id": DevKeys.devId};
        var result = await _todoServices.getAll(payload);
        if (result is ErrorModel) {
          setBusy(LoadingState.IDLE);
          print(result.error);
          showErrorSnackbar('Error', result.error, context);
        } else {
          print(result.data);
          List<Tasks> y = result.data;
          y.sort((a, b) => DateTime.parse(a.updatedAt!)
              .compareTo(DateTime.parse(b.updatedAt!)));
          y.sort((a, b) {
            if (b.isCompleted ?? false) {
              return 1;
            }
            return -1;
          });
          _tasks = y.reversed.toList();
          notifyListeners();
          setBusy(LoadingState.DONE);
        }
      }
    } catch (e) {
      print(e);
      setBusy(LoadingState.IDLE);
      showErrorSnackbar('Error', 'An error occured. Try again later', context);
    }
  }

  navToNew(ctx) {
    pushScreen(CreateTask(isNew: true, data: Tasks()), context: ctx);
  }
}
