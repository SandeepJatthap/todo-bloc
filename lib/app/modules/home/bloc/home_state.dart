part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure ,successDelete, successDone}

final class TodosOverviewState extends Equatable {
  const TodosOverviewState({
    this.status = HomeStatus.initial,
    this.todos = const [],
    this.lastDeletedTodo,
  });

  final HomeStatus status;
  final List<TaskModel> todos;
  final TaskModel? lastDeletedTodo;


  TodosOverviewState copyWith({
    HomeStatus Function()? status,
    List<TaskModel> Function()? todos,
    TaskModel? Function()? lastDeletedTodo,
  }) {
    return TodosOverviewState(
      status: status != null ? status() : this.status,
      todos: todos != null ? todos() : this.todos,
      lastDeletedTodo:
      lastDeletedTodo != null ? lastDeletedTodo() : this.lastDeletedTodo,
    );
  }

  @override
  List<Object?> get props => [
    status,
    todos,
    lastDeletedTodo,
  ];
}