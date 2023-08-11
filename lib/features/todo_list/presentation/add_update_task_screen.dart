import 'dart:developer';

import 'package:crud_local_testing_app/config/app_strings.dart';
import 'package:crud_local_testing_app/core/database_handler.dart';
import 'package:crud_local_testing_app/features/todo_list/data/models/todo_model.dart';
import 'package:crud_local_testing_app/features/todo_list/presentation/todo_list_screen.dart';
import 'package:crud_local_testing_app/features/todo_list/presentation/widgets/title.dart';
import 'package:flutter/material.dart';

class AddUpdateTaskScreen extends StatefulWidget {
  final int? id;
  final String? status;
  final String? color;
  final String? description;
  final String? date;
  final bool? isUpdate;
  const AddUpdateTaskScreen(
      {super.key,
      this.id,
      this.status,
      this.color,
      this.description,
      this.date,
      this.isUpdate});

  @override
  State<AddUpdateTaskScreen> createState() => _AddUpdateTaskScreenState();
}

class _AddUpdateTaskScreenState extends State<AddUpdateTaskScreen> {
  DatabaseHandler? _databaseHandler;

  late Future<List<TodoModel>> todoList;

  bool pink = false;
  bool green = false;

  @override
  void initState() {
    super.initState();
    _databaseHandler = DatabaseHandler();
    loadData();
  }

  loadData() async {
    todoList = _databaseHandler!.getTodoListData();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: widget.status);
    final TextEditingController descriptionController =
        TextEditingController(text: widget.description);
    final TextEditingController dateController =
        TextEditingController(text: widget.date);
    final TextEditingController timeController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.isUpdate == true ? AppStrings.updateTask : AppStrings.newTask,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            12.0,
          ),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const TitleWidget(title: AppStrings.color),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [
         
                  InkWell(
                    onTap: () => pink = true,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink,
                      ),
                    ),
                  ),
       
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  InkWell(
                    onTap: ()=> green = true,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const TitleWidget(title: AppStrings.name),
              TextFormField(
                controller: nameController,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const TitleWidget(title: AppStrings.description),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const TitleWidget(title: AppStrings.date),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextFormField(
                controller: dateController,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const TitleWidget(title: AppStrings.time),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextFormField(
                controller: timeController,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: 'success--',
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.isUpdate == true) {
                          _databaseHandler!.update(TodoModel(
                            id: widget.id,
                            status: nameController.text,
                            description: descriptionController.text,
                            date: dateController.text,
                            //? sending color temporarily, it needs a modification
                            color: pink == true ? "pink" : "green",
                          ));
                        } else {
                          _databaseHandler!.insert(TodoModel(
                            status: nameController.text,
                            description: descriptionController.text,
                            date: dateController.text,
                            //? sending color temporarily, it needs a modification
                            color: pink == true ? "pink" : "green",
                          ));
                        }

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const TodoListScreen()));
                        nameController.clear();
                        descriptionController.clear();
                        dateController.clear();
                        timeController.clear();

                        log("Data Added");
                      },
                      child: const Text(AppStrings.add),
                    ),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
