import '../model/task_create_response.dart';
import '../model/task_model.dart';
import '../provider/remote/DiaApiBaseHelper.dart';

class TodoRepository {
  Future<List<TaskModel>> getAllTodos() async {
    try {
      var res = await DioApiBaseHelper.get(
        DioApiBaseHelper.todo,
      );
      return List<TaskModel>.from(res.map((l) => TaskModel.fromJson(l)))
          .toList();
    } catch (error) {
      return [];
    }
  }

  Future<TaskCreateResponse?> createTodo(Map<String, dynamic> data) async {
    try {
      var res = await DioApiBaseHelper.postDio(DioApiBaseHelper.todo, data);
      return TaskCreateResponse.fromJson(res);
    } catch (error) {
      return null;
    }
  }

  Future<TaskCreateResponse?> markTaskDone(String id) async {
    try {
      var res =
          await DioApiBaseHelper.postDio("${DioApiBaseHelper.todo}/$id", {});
      return TaskCreateResponse.fromJson(res);
    } catch (error) {
      return null;
    }
  }

  Future<TaskCreateResponse?> updateTodo(Map<String, dynamic> data) async {
    try {
      var res = await DioApiBaseHelper.putDio(DioApiBaseHelper.todo, data);
      return TaskCreateResponse.fromJson(res);
    } catch (error) {
      return null;
    }
  }

  Future<TaskCreateResponse?> deleteDio(String id) async {
    try {
      var res = await DioApiBaseHelper.deleteDio(DioApiBaseHelper.todo, id);
      return TaskCreateResponse.fromJson(res);
    } catch (error) {
      return null;
    }
  }
}
