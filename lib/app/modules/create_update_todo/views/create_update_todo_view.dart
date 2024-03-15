import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/app/data/model/task_model.dart';
import 'package:todo_bloc/app/global_components/background.dart';

import '../../../data/repository/todo_repository.dart';
import '../bloc/add_task_bloc.dart';
import '../components/app_text_field.dart';

class EditTodoPage extends StatelessWidget {
  const EditTodoPage({super.key});

  static Route<void> route({TaskModel? initialTodo}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditTodoBloc(
          todosRepository: context.read<TodoRepository>(),
          initialTodo: initialTodo,
        )..checkNetwork(),
        child: const EditTodoPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTodoBloc, EditTodoState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditTodoStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: EditTodoView(),
    );
  }
}

class EditTodoView extends StatelessWidget {
  EditTodoView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final status = context.select((EditTodoBloc bloc) => bloc.state.status);
    final todo = context.select((EditTodoBloc bloc) => bloc.state.initialTodo);
    final isNewTodo = context.select(
      (EditTodoBloc bloc) => bloc.state.isNewTodo,
    );

    return Background(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          isNewTodo ? "Create Task" : "Update Task",
        ),
      ),
      bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: isNewTodo
                ? ElevatedButton(
                    onPressed: status == EditTodoStatus.loading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<EditTodoBloc>()
                                  .add(const EditTodoSubmitted());
                            }
                          },
                    child: status == EditTodoStatus.loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          )
                        : const Text('Submit'),
                  )
                : Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: (status == EditTodoStatus.loading ||
                                status == EditTodoStatus.deleting)
                            ? null
                            : () {
                                context
                                    .read<EditTodoBloc>()
                                    .add(DeleteTaskEvent(todo!.id!.toString()));
                              },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        child: status == EditTodoStatus.deleting
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              )
                            : const Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                      )),
                      if (todo?.status == 0) const SizedBox(width: 10),
                      if (todo?.status == 0)
                        Expanded(
                            child: ElevatedButton(
                          onPressed: (status == EditTodoStatus.loading ||
                                  status == EditTodoStatus.deleting)
                              ? null
                              : () {
                                  context
                                      .read<EditTodoBloc>()
                                      .add(DoneTaskEvent(todo!.id!.toString()));
                                },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          child: status == EditTodoStatus.loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text(
                                  'Mark Done',
                                  style: TextStyle(color: Colors.white),
                                ),
                        )),
                    ],
                  ),
          )),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  initialValue: todo?.taskName ?? "",
                  // readOnly: controller.todo!=null,
                  hint: "Title",
                  minLines: 4,
                  maxLines: 5,
                  validator: (String? value) {
                    return value == null || value.length < 6
                        ? 'Enter a valid title'
                        : null;
                  },
                  onChange: (value) {
                    context
                        .read<EditTodoBloc>()
                        .add(EditTodoTitleChanged(value ?? ""));
                  },
                ),
                if (todo != null && todo.status == 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.verified, size: 22),
                        SizedBox(width: 5),
                        Expanded(
                            child: Text("This task is marked as complete."))
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
