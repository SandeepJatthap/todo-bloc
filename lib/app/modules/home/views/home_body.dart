import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/app/modules/home/components/no_data_view.dart';
import '../../create_update_todo/views/create_update_todo_view.dart';
import '../components/todo_item_view.dart';
import '../bloc/home_bloc.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, TodosOverviewState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == HomeStatus.successDelete ||
                state.status == HomeStatus.successDone) {
              context
                  .read<HomeBloc>()
                  .add(const TodosOverviewSubscriptionRequested());
            }
          },
        ),
        BlocListener<HomeBloc, TodosOverviewState>(
          listenWhen: (previous, current) =>
              previous.lastDeletedTodo != current.lastDeletedTodo &&
              current.lastDeletedTodo != null,
          listener: (context, state) {},
        ),
      ],
      child: BlocBuilder<HomeBloc, TodosOverviewState>(
        builder: (context, state) {
          if (state.todos.isEmpty) {
            if (state.status == HomeStatus.loading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state.status != HomeStatus.success) {
              return const SizedBox();
            } else {
              return const NoDataUi();
            }
          }

          return CupertinoScrollbar(
            child: ListView(
              children: [
                for (final todo in state.todos)
                  TodoItemView(
                    onClick: () {
                      Navigator.of(context)
                          .push(
                        EditTodoPage.route(initialTodo: todo),
                      )
                          .then((value) {
                        context
                            .read<HomeBloc>()
                            .add(const TodosOverviewSubscriptionRequested());
                      });
                    },
                    todoItem: todo,
                    onDelete: () {
                      context
                          .read<HomeBloc>()
                          .add(TodosOverviewTodoDeleted(todo));
                    },
                    onDone: () {
                      context
                          .read<HomeBloc>()
                          .add(DoneTaskEvent(todo.id.toString()));
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
