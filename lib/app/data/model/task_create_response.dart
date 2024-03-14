class TaskCreateResponse {
  TaskCreateResponse({
    String? taskName,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) {
    _taskName = taskName;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  TaskCreateResponse.fromJson(dynamic json) {
    _taskName = json['task_name'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }

  String? _taskName;
  String? _updatedAt;
  String? _createdAt;
  num? _id;

  String? get taskName => _taskName;

  String? get updatedAt => _updatedAt;

  String? get createdAt => _createdAt;

  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['task_name'] = _taskName;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}
