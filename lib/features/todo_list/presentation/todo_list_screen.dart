import 'package:crud_local_testing_app/core/database_handler.dart';
import 'package:crud_local_testing_app/features/todo_list/data/models/todo_model.dart';
import 'package:crud_local_testing_app/features/todo_list/presentation/widgets/update_task_screen.dart';
import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  DatabaseHandler? databaseHandler;
  late Future<List<TodoModel>> screenData;
  @override
  void initState() {
    super.initState();
    databaseHandler = DatabaseHandler();
    loadData();
  }

  loadData() async {
    screenData = databaseHandler!.getTodoListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Expanded(child: FutureBuilder(
          builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
            if (!snapshot.hasData || snapshot.hasData == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.length == 0) {
              return const Center(
                child: Text("No Tasks Found"),
              );
            } else {
              return Container();
            }
          },
        ))
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UpdateTaskScreen()));
        },
      ),
    );
  }
}
