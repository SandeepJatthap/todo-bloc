import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../data/model/task_model.dart';

class TodoItemView extends StatelessWidget {
  final Function() onClick;
  final Function() onDelete;
  final Function() onDone;
  final TaskModel todoItem;

  const TodoItemView({
    super.key,
    required this.onClick,
    required this.todoItem,
    required this.onDelete,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(todoItem.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (c) {
              onDelete();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          if (todoItem.status == 0)
            SlidableAction(
              onPressed: (c) {
                onDone();
              },
              backgroundColor: const Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: 'Done',
            ),
        ],
      ),
      child: _buildTaskView(context),
    );
  }

  Widget _buildTaskView(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: <Widget>[
            ListTile(
                title: Text(
                  todoItem.taskName ?? "",
                  style: TextStyle(
                    fontSize: 18.0,
                    decoration: todoItem.status == 0
                        ? TextDecoration.none
                        : TextDecoration.lineThrough,
                  ),
                ),
                subtitle: Text(
                  'Created at: ${todoItem.createAtFormatted}',
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),

                trailing:
                    todoItem.status == 1 ? const Icon(Icons.verified) : null,
                onTap: onClick),
            const Divider(),
          ],
        ),
      );
}
