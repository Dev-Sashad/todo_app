import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/core/model/todo_model.dart';
import 'package:todo_app/ui/widget/custom_text_form_field.dart';
import 'package:todo_app/ui/widget/general_button.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/enum.dart';
import 'package:todo_app/utils/helpers.dart';
import 'create_vm.dart';

class CreateTask extends StatefulWidget {
  final bool? isNew;
  final Tasks? data;
  CreateTask({this.isNew, this.data});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateTaskVm>.reactive(
        onModelReady: (v) {
          if (widget.isNew == false) {
            v.initField(widget.data!);
          }
        },
        viewModelBuilder: () => CreateTaskVm(),
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              leading: widget.isNew!
                  ? IconButton(
                      onPressed: () => vm.pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.white,
                      ),
                    )
                  : null,
              title: Text(
                'Create Task',
                style: TextStyle(color: AppColors.white, fontSize: 18),
              ),
              actions: [
                widget.isNew!
                    ? SizedBox()
                    : IconButton(
                        onPressed: () => vm.delete(widget.data!, context),
                        icon: Icon(
                          Icons.delete,
                          color: AppColors.white,
                        ),
                      )
              ],
              centerTitle: false,
            ),
            body: Container(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        customYMargin(15),
                        CustomTextFormField(
                          controller: vm.title,
                          hint: "What do you want to do?",
                          label: "Title",
                          height: 48,
                          maxLines: 1,
                          expands: false,
                        ),
                        customYMargin(15),
                        CustomTextFormField(
                          controller: vm.desc,
                          hint: "Describe your task",
                          label: "Descripton",
                          textInputType: TextInputType.multiline,
                          height: 96,
                          maxLines: 4,
                          expands: true,
                        ),
                        customYMargin(15),
                        GeneralButton(
                          loading: vm.busy == LoadingState.LOADING,
                          buttonText: 'Save',
                          onPressed: () {
                            if (vm.title.text.isNotEmpty &&
                                vm.desc.text.isNotEmpty) {
                              if (widget.isNew!) {
                                vm.postTask(widget.data!, context);
                              } else {
                                vm.updateTask(widget.data!, context);
                              }
                            } else {
                              showErrorSnackbar(
                                  "Ooops", "Kindly fill empty fields", context);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
