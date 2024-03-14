import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../data/model/task_model.dart';
import '../../../data/repository/todo_repository.dart';
import '../../../utils/message_handler.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, TodosOverviewState> {
  HomeBloc({
    required TodoRepository todosRepository,
    required BuildContext context,
  })  : _todosRepository = todosRepository,
        _context = context,
        super(const TodosOverviewState()) {
    on<TodosOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TodosOverviewTodoDeleted>(_onTodoDeleted);
    on<DoneTaskEvent>(_onTaskDone);
  }

  final TodoRepository _todosRepository;
  final BuildContext _context;

  Future<void> _onSubscriptionRequested(
    TodosOverviewSubscriptionRequested event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => HomeStatus.loading));

    await emit.forEach<List<TaskModel>>(
      _todosRepository.getAllTodos().asStream().asBroadcastStream(),
      onData: (todos) => state.copyWith(
        status: () => HomeStatus.success,
        todos: () => todos,
      ),
      onError: (_, __) => state.copyWith(
        status: () => HomeStatus.failure,
      ),
    );
  }

  Future<void> _onTodoDeleted(
    TodosOverviewTodoDeleted event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(lastDeletedTodo: () => event.todo));
    var response = await _todosRepository.deleteDio(event.todo.id.toString());
    if (response != null && response.id != null) {
      emit(state.copyWith(status: () => HomeStatus.successDelete));
      AppMessageHandler.showSuccessMessage("Task deleted");
    } else {
      AppMessageHandler.showErrorMessage("Failed to delete task");
    }
  }

  Future<void> _onTaskDone(
    DoneTaskEvent event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => HomeStatus.loading));
    try {
      var response = await _todosRepository.markTaskDone(event.id);
      if (response != null && response.id != null) {
        emit(state.copyWith(status: () => HomeStatus.successDone));
        AppMessageHandler.showSuccessMessage("Task completed");
      } else {
        emit(state.copyWith(status: () => HomeStatus.failure));
        AppMessageHandler.showErrorMessage("Failed to done task");
      }
    } catch (e) {
      emit(state.copyWith(status: () => HomeStatus.failure));
      AppMessageHandler.showErrorMessage("Failed to done task");
    }
  }
}
