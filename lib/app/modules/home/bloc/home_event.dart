part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class TodosOverviewSubscriptionRequested extends HomeEvent {
  const TodosOverviewSubscriptionRequested();
}

final class DoneTaskEvent extends HomeEvent {
  const DoneTaskEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class TodosOverviewTodoDeleted extends HomeEvent {
  const TodosOverviewTodoDeleted(this.todo);

  final TaskModel todo;

  @override
  List<Object> get props => [todo];
}
