import 'package:intl/intl.dart';

class TaskModel {
  TaskModel({
    num? id,
    String? taskName,
    String? createdAt,
    String? updatedAt,
    num? status,
  }) {
    _id = id;
    _taskName = taskName;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _status = status;
  }

  TaskModel.fromJson(dynamic json) {
    _id = json['id'];
    _taskName = json['task_name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _status = json['status'];
  }

  num? _id;
  String? _taskName;
  String? _createdAt;
  String? _updatedAt;
  num? _status;

  num? get id => _id;

  String? get taskName => _taskName;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  num? get status => _status;

  String get createAtFormatted => DateFormat('dd-MM-yyyy hh:mm a').format(
      DateFormat("yyyy-MM-ddTHH:mm:ss").parse(createdAt!, true).toLocal());

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['task_name'] = _taskName;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['status'] = _status;
    return map;
  }
}
