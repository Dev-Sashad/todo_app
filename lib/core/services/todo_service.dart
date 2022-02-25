import 'package:todo_app/core/model/error_model.dart';
import 'package:todo_app/core/model/success_model.dart';
import 'package:todo_app/core/model/todo_model.dart';
import 'package:todo_app/utils/graph_ql/graph_ql_service.dart';
import 'package:todo_app/utils/graph_ql/mutations.dart';

class TodoServices {
  postData(Map<String, dynamic> payload) async {
    graphQlService config = graphQlService();
    var result = await config.gpMutate(
        mutationDocument: Mutations().post, data: payload);
    if (result is ErrorModel) {
      return ErrorModel(result.error);
    } else {
      print(result.data.toString());
      var value = result.data;
      Tasks data = Tasks.fromJson(value);
      return SuccessModel(data);
    }
  }

  updateData(Map<String, dynamic> payload) async {
    graphQlService config = graphQlService();
    var result = await config.gpMutate(
        mutationDocument: Mutations().update, data: payload);
    if (result is ErrorModel) {
      return ErrorModel(result.error);
    } else {
      print(result.data);
      var value = result.data["update_tasks_by_pk"];
      Tasks data = Tasks.fromJson(value);
      return SuccessModel(data);
    }
  }

  deleteData(Map<String, dynamic> payload) async {
    graphQlService config = graphQlService();
    var result = await config.gpMutate(
        mutationDocument: Mutations().delete, data: payload);
    if (result is ErrorModel) {
      return ErrorModel(result.error);
    } else {
      print(result.data.toString());
      print(result.data);
      var value = result.data["delete_tasks_by_pk"];
      Tasks data = Tasks.fromJson(value);
      return SuccessModel(data);
    }
  }

  getAll(Map<String, dynamic> payload) async {
    graphQlService config = graphQlService();
    var result = await config.gpQuery(
        queryDocument: Mutations().queryAll, data: payload);
    if (result is ErrorModel) {
      return ErrorModel(result.error);
    } else {
      print(result.data.toString());
      var value = result.data["tasks"];
      List<Tasks> data = (value as List).map((e) => Tasks.fromJson(e)).toList();
      return SuccessModel(data);
    }
  }

  getById(Map<String, dynamic> payload) async {
    graphQlService config = graphQlService();
    var result = await config.gpQuery(
        queryDocument: Mutations().queryById, data: payload);
    if (result is ErrorModel) {
      return ErrorModel(result.error);
    } else {
      print(result.data.toString());
      var value = result.data["tasks_by_pk"];
      Tasks data = Tasks.fromJson(value);
      return SuccessModel(data);
    }
  }
}
