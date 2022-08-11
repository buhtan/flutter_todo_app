import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapilacaklar_uygulamasi/widgets/providers/all_providers.dart';
import 'package:yapilacaklar_uygulamasi/widgets/title_widget.dart';
import 'package:yapilacaklar_uygulamasi/widgets/todo_list_item_widget.dart';
import 'package:yapilacaklar_uygulamasi/widgets/toolbar_widget.dart';


class TodoApp extends ConsumerWidget {
  TodoApp({Key? key}) : super(key: key);

  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          TextField(
            controller: newTodoController,
            decoration:
                const InputDecoration(labelText: 'What will you do ?'),
            onSubmitted: (newTodo) {
              ref.read(todoListProvider.notifier).addTodo(newTodo);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ToolBarWidget(),
          allTodos.length == 0
              ? const Center(
                  child: Text('No task'))
              : const SizedBox(),
          for (var i = 0; i < allTodos.length; i++)
            Dismissible(
              key: ValueKey(allTodos[i].id),
              onDismissed: (_) {
                ref.read(todoListProvider.notifier).remove(allTodos[i]);
              },
              child: ProviderScope(
                overrides: [
                  currentTodoProvider.overrideWithValue(allTodos[i]),
                ],
                child: const TodoListItemWidget(),
              ),
            ),
        
        ],
      ),
    );
  }
}
