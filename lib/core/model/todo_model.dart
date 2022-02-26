class TodoResponse {
  TodoData? data;

  TodoResponse({this.data});

  TodoResponse.fromJson(Map<String, dynamic> json) {
    if (json["data"] is Map)
      this.data = json["data"] == null ? null : TodoData.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) data["data"] = this.data!.toJson();
    return data;
  }
}

class TodoData {
  List<Tasks>? tasks;

  TodoData({this.tasks});

  TodoData.fromJson(Map<String, dynamic> json) {
    if (json["tasks"] is List)
      this.tasks = json["tasks"] == null
          ? null
          : (json["tasks"] as List).map((e) => Tasks.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tasks != null)
      data["tasks"] = this.tasks!.map((e) => e.toJson()).toList();
    return data;
  }
}

class Tasks {
  String? id;
  String? developerId;
  String? description;
  String? createdAt;
  bool? isCompleted;
  String? title;
  String? updatedAt;

  Tasks(
      {this.id,
      this.developerId,
      this.description,
      this.createdAt,
      this.isCompleted,
      this.title,
      this.updatedAt});

  Tasks.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) this.id = json["id"];
    if (json["developer_id"] is String) this.developerId = json["developer_id"];
    if (json["description"] is String)
      this.description = json["description"] ?? "";
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["isCompleted"] is bool)
      this.isCompleted = json["isCompleted"] ?? false;
    if (json["title"] is String) this.title = json["title"] ?? "";
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["developer_id"] = this.developerId;
    data["description"] = this.description;
    data["created_at"] = this.createdAt;
    data["isCompleted"] = this.isCompleted;
    data["title"] = this.title;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}
