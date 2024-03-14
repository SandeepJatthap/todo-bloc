part of 'add_task_bloc.dart';

sealed class EditTodoEvent extends Equatable {
  const EditTodoEvent();

  @override
  List<Object> get props => [];
}

final class EditTodoTitleChanged extends EditTodoEvent {
  const EditTodoTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

final class DeleteTaskEvent extends EditTodoEvent {
  const DeleteTaskEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class DoneTaskEvent extends EditTodoEvent {
  const DoneTaskEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class EditTodoSubmitted extends EditTodoEvent {
  const EditTodoSubmitted();
}
