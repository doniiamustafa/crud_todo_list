import 'package:crud_local_testing_app/core/database_handler.dart';
import 'package:crud_local_testing_app/features/todo_list/data/models/todo_model.dart';
import 'package:crud_local_testing_app/features/todo_list/presentation/add_update_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  DatabaseHandler? databaseHandler;
  late Future<List<TodoModel>> screenData;
  String getColor = "pink";
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
      backgroundColor: Colors.pink[100],
      appBar: AppBar(),
      body: Column(children: [
        Expanded(
            child: FutureBuilder(
          future: screenData,
          builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
            // ignore: unnecessary_null_comparison
            if (!snapshot.hasData || snapshot.hasData == null)
            // if (!snapshot.hasData)
            {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.length == 0) {
              return const Center(
                child: Text("No Tasks Found"),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    int todoId = snapshot.data![index].id!.toInt();
                    String status = snapshot.data![index].status!.toString();
                    String description =
                        snapshot.data![index].description!.toString();
                    String date = snapshot.data![index].date!.toString();

                    getColor = snapshot.data![index].color!.toString();
                    return InkWell(
                      onTap: () => Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(
                              builder: (context) => AddUpdateTaskScreen(
                                    id: todoId,
                                    status: status,
                                    description: description,
                                    date: date,
                                    color: getColor,
                                    isUpdate: true,
                                  ))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Dismissible(
                          key: ValueKey<int>(todoId),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            child: const Icon(Icons.delete_forever),
                          ),
                          onDismissed: (DismissDirection direction) {
                            setState(() {
                              databaseHandler!.delete(todoId);
                              screenData = databaseHandler!.getTodoListData();
                              snapshot.data!.remove(snapshot.data![index]);
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width:
                                          MediaQuery.of(context).size.width *
                                              0.1,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                           //? temporary solution for choosing color
                                        color: getColor == "pink"
                                            ? Colors.pink
                                            : Colors.green,
                                      ),
                                    ),
                                    title: Text(status),
                                    trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(DateFormat('d MMM')
                                              .format(DateTime.now())),
                                          Text(
                                            date,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    );
                  });
            }
          },
        ))
      ]),
      floatingActionButton: Hero(
        tag: "success_1**",
        child: FloatingActionButton(
          heroTag: null,
          backgroundColor: Colors.amber,
          child: const Icon(Icons.add),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddUpdateTaskScreen())),
        ),
      ),
    );
  }
}
