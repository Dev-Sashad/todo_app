import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/utils/enum.dart';
import 'package:todo_app/utils/helpers.dart';
import '../../../core/model/todo_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/screensize.dart';
import '../../widget/todo_tile.dart';
import 'home_vm.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeVm>.reactive(
        onModelReady: (v) {
          v.getdata(context);
        },
        viewModelBuilder: () => HomeVm(),
        builder: (context, vm, child) {
          if (vm.busy == LoadingState.DONE) {
            return Scaffold(
              appBar: appBar(),
              body: Container(
                margin: EdgeInsets.only(top: 10),
                child: ListView.builder(
                    itemCount: vm.tasks.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (c, i) {
                      print(vm.tasks.length);
                      return TodoTile(
                        index: i,
                        data: vm.tasks[i],
                        // check: vm.updateMarked(vm.tasks[i], context),
                        // unCheck: vm.updateUnMarked(vm.tasks[i], context),
                      );
                    }),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FloatingActionButton(
                  onPressed: () => vm.navToNew(context),
                  backgroundColor: AppColors.primaryColor,
                  splashColor: AppColors.primaryColor,
                  child: Icon(Icons.add, color: AppColors.white),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
            );
          } else if (vm.busy == LoadingState.LOADING) {
            return Scaffold(
              appBar: appBar(),
              body: SafeArea(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [0, 1, 2]
                          .map(
                            (e) => Shimmer.fromColors(
                              highlightColor: Colors.white,
                              baseColor: AppColors.grey_light,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.grey_light,
                                ),
                                width: width(100, context),
                              ),
                              period: Duration(milliseconds: 500),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FloatingActionButton(
                  onPressed: () => vm.navToNew(context),
                  backgroundColor: AppColors.primaryColor,
                  splashColor: AppColors.primaryColor,
                  child: Icon(Icons.add, color: AppColors.white),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
            );
          } else {
            return Scaffold(
              appBar: appBar(),
              body: Container(
                height: height(100, context),
                width: width(100, context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Todo List is empty',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                    customYMargin(10),
                    Text(
                      'Create a task',
                      style: TextStyle(color: AppColors.grey, fontSize: 18),
                    ),
                  ],
                ),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FloatingActionButton(
                  onPressed: () => vm.navToNew(context),
                  backgroundColor: AppColors.primaryColor,
                  splashColor: AppColors.primaryColor,
                  child: Icon(Icons.add, color: AppColors.white),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniEndDocked,
            );
          }
        });
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      automaticallyImplyLeading: false,
      title: Text(
        'Todo List',
        style: TextStyle(color: AppColors.white, fontSize: 18),
      ),
      centerTitle: false,
    );
  }

  // Widget float({Function? onpressed}) {
  //   return Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: FloatingActionButton(
  //       onPressed: () => onpressed,
  //       backgroundColor: AppColors.primaryColor,
  //       splashColor: AppColors.primaryColor,
  //       child: Icon(Icons.add, color: AppColors.white),
  //     ),
  //   );
  // }
}
