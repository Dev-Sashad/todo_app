import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/model/todo_model.dart';
import 'package:todo_app/ui/screens/create_todo/create.dart';
import 'package:todo_app/ui/screens/home/home.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/helpers.dart';
import 'package:todo_app/utils/screensize.dart';
import '../../core/model/error_model.dart';
import '../../core/services/todo_service.dart';
import '../../utils/locator.dart';
import '../../utils/router/navigation_service.dart';

class TodoTile extends StatefulWidget {
  final int? index;
  final Tasks? data;
  TodoTile({this.data, this.index});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  final TodoServices _todoServices = locator<TodoServices>();
  late bool isMarked;

  reload(BuildContext context) async {
    final old = (ModalRoute.of(context) as PageRoute);
    Navigator.replace(context,
        oldRoute: old,
        newRoute: MaterialPageRoute(builder: (context) => HomePage()));
  }

  updateMarked(Tasks value, context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var isConnected = connectivityResult != ConnectivityResult.none;
    try {
      if (!isConnected) {
        showErrorSnackbar(
            "Connection Error", "Kindly check internet connection", context);
      } else {
        var payload = {
          "id": value.id,
          "payload": {
            "isCompleted": true,
            "title": value.title,
            "description": value.description
          }
        };
        var result = await _todoServices.updateData(payload);
        if (result is ErrorModel) {
          print(result.error);
          showErrorSnackbar('Error', result.error, context);
        } else {
          showSuccessSnackbar('Success', 'Task completed', context);
          return result.data;
        }
      }
    } catch (e) {
      showErrorSnackbar('Error', 'An error occured. Try again later', context);
    }
  }

  updateUnMarked(Tasks value, context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var isConnected = connectivityResult != ConnectivityResult.none;
    try {
      if (!isConnected) {
        showErrorSnackbar(
            "Connection Error", "Kindly check internet connection", context);
      } else {
        var payload = {
          "id": value.id,
          "payload": {
            "isCompleted": false,
            "title": value.title,
            "description": value.description
          }
        };
        var result = await _todoServices.updateData(payload);
        if (result is ErrorModel) {
          print(result.error);
          showErrorSnackbar('Error', result.error, context);
        } else {
          showSuccessSnackbar('Success', 'Task unmarked', context);
          return result.data;
        }
      }
    } catch (e) {
      showErrorSnackbar('Error', 'An error occured. Try again later', context);
    }
  }

  @override
  void initState() {
    super.initState();
    isMarked = widget.data!.isCompleted!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushScreen(
          CreateTask(
            isNew: false,
            data: widget.data!,
          ),
          context: context),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 44,
                    width: 44,
                    child: Center(
                      child: Text(
                        isMarked
                            ? widget.data!.title!.substring(0, 1)
                            : widget.index.toString(),
                        style: TextStyle(
                            color:
                                isMarked ? AppColors.green : AppColors.yellow,
                            fontSize: 14),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: isMarked
                            ? AppColors.green_light
                            : AppColors.yellow_light,
                        border: Border.all(
                            color:
                                isMarked ? AppColors.green : AppColors.yellow)),
                  ),
                  customXMargin(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width(60, context),
                        child: Text(
                          widget.data!.title ?? "",
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 14,
                              decoration: isMarked
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                      ),
                      customYMargin(5),
                      Container(
                        width: width(60, context),
                        child: Text(
                          widget.data!.description ?? "",
                          style: TextStyle(color: AppColors.grey, fontSize: 12),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              isMarked
                  ? IconButton(
                      onPressed: () async {
                        if (isMarked) {
                          await updateUnMarked(widget.data!, context)
                              .then((value) {
                            setState(() {
                              isMarked = value.isCompleted!;
                            });
                            reload(context);
                          });
                        }
                      },
                      icon: Icon(
                        Icons.check_box,
                        color: AppColors.green,
                      ))
                  : IconButton(
                      onPressed: () async {
                        if (isMarked == false) {
                          await updateMarked(widget.data!, context)
                              .then((value) {
                            setState(() {
                              isMarked = value.isCompleted!;
                            });
                            reload(context);
                          });
                        }
                      },
                      icon: Icon(
                        Icons.check_box_outline_blank,
                        color: AppColors.grey,
                      ))
            ],
          )),
    );
  }
}
