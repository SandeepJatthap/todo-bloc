part of 'add_task_bloc.dart';

enum EditTodoStatus { initial, loading, success, failure, deleting }

final class EditTodoState extends Equatable {
  const EditTodoState({
    this.status = EditTodoStatus.initial,
    this.initialTodo,
    this.title = '',
    this.description = '',
  });

  final EditTodoStatus status;
  final TaskModel? initialTodo;
  final String title;
  final String description;

  bool get isNewTodo => initialTodo == null;

  EditTodoState copyWith({
    EditTodoStatus? status,
    TaskModel? initialTodo,
    String? title,
    String? description,
  }) {
    return EditTodoState(
      status: status ?? this.status,
      initialTodo: initialTodo ?? this.initialTodo,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [status, initialTodo, title, description];
}
