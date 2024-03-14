import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/app/global_components/background.dart';

import '../../../data/repository/todo_repository.dart';
import '../../create_update_todo/views/create_update_todo_view.dart';
import '../bloc/home_bloc.dart';
import 'home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => HomeBloc(
          todosRepository: context.read<TodoRepository>(),
          context: context,
        )..add(const TodosOverviewSubscriptionRequested()),
        child: const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Tasks'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          context
              .read<HomeBloc>()
              .add(const TodosOverviewSubscriptionRequested());
        },
        child: const HomeBody(),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        key: const Key('newtask'),
        onPressed: () {
          Navigator.of(context).push(EditTodoPage.route()).then((value) {
            context
                .read<HomeBloc>()
                .add(const TodosOverviewSubscriptionRequested());
          });
        },
        child: const Icon(Icons.add),
      ),
    ));
  }
}
