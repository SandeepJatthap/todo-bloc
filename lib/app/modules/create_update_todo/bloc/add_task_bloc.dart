import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:todo_bloc/app/data/model/task_model.dart';
import 'package:todo_bloc/app/utils/message_handler.dart';
import '../../../data/repository/todo_repository.dart';
import '../../../utils/services/internet_connectivity_service.dart';

part 'add_task_event.dart';

part 'add_task_state.dart';

class EditTodoBloc extends Bloc<EditTodoEvent, EditTodoState> {
  EditTodoBloc({
    required TodoRepository todosRepository,
    required TaskModel? initialTodo,
  })  : _todosRepository = todosRepository,
        super(
          EditTodoState(
            initialTodo: initialTodo,
            title: initialTodo?.taskName ?? '',
            description: '',
          ),
        ) {
    on<EditTodoTitleChanged>(_onTitleChanged);
    on<DeleteTaskEvent>(_onTaskDelete);
    on<DoneTaskEvent>(_onTaskDone);
    on<EditTodoSubmitted>(_onSubmitted);
    checkNetwork();
  }

  void checkNetwork() {
    hasConnection = connectionStatus.hasConnection;
    connectionStatus.myStream.listen((event) {
      hasConnection = event;
    });
  }

  bool hasConnection = true;
  final connectionStatus = ConnectionStatusSingleton.instance;

  final TodoRepository _todosRepository;

  void _onTitleChanged(
    EditTodoTitleChanged event,
    Emitter<EditTodoState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  Future<void> _onTaskDelete(
    DeleteTaskEvent event,
    Emitter<EditTodoState> emit,
  ) async {
    if (hasConnection) {
      emit(state.copyWith(status: EditTodoStatus.deleting));
      try {
        final todo = state.initialTodo;
        var response = await _todosRepository.deleteDio(todo!.id.toString());

        if (response != null && response.id != null) {
          emit(state.copyWith(status: EditTodoStatus.success));

          AppMessageHandler.showSuccessMessage("Task deleted");
        } else {
          AppMessageHandler.showErrorMessage("Failed to delete task");
        }
      } catch (e) {
        AppMessageHandler.showErrorMessage("Failed to delete task");
        emit(state.copyWith(status: EditTodoStatus.failure));
      }
    } else {
      AppMessageHandler.showErrorMessage("Please check internet connection");
    }
  }

  Future<void> _onTaskDone(
    DoneTaskEvent event,
    Emitter<EditTodoState> emit,
  ) async {
    emit(state.copyWith(status: EditTodoStatus.loading));
    try {
      final todo = state.initialTodo;
      var response = await _todosRepository.markTaskDone(todo!.id.toString());
      if (response != null && response.id != null) {
        emit(state.copyWith(status: EditTodoStatus.success));
        AppMessageHandler.showSuccessMessage("Task completed");
      } else {
        emit(state.copyWith(status: EditTodoStatus.failure));
        AppMessageHandler.showErrorMessage("Failed to done task");
      }
    } catch (e) {
      emit(state.copyWith(status: EditTodoStatus.failure));
    }
  }

  Future<void> _onSubmitted(
    EditTodoSubmitted event,
    Emitter<EditTodoState> emit,
  ) async {
    emit(state.copyWith(status: EditTodoStatus.loading));
    try {
      await _todosRepository.createTodo({'task_name': state.title});
      emit(state.copyWith(status: EditTodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditTodoStatus.failure));
    }
  }
}
