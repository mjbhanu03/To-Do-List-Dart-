import 'package:assignment2/List/tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeWithTabs extends StatefulWidget {
  _HomeWithTabs createState() => _HomeWithTabs();
}

class _HomeWithTabs extends State<HomeWithTabs> {
  TextEditingController nameController = TextEditingController();
  int? editIndex;

  List<Tasks> tasksList = [];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home with Tabs'),
          bottom: TabBar(
            tabs: [Tab(text: 'Display'), Tab(icon: Icon(Icons.add))],
          ),
        ),
        body: TabBarView(
          children: [
            tasksList.isEmpty
                ? Center(child: Text('No Task Added'))
                : ListView.builder(
                  itemCount: tasksList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tasksList[index].name),
                      subtitle: Text(
                        'Time: ${tasksList[index].time}, Date: ${tasksList[index].date}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        ElevatedButton(onPressed: (){
                          setState(() {
                            nameController.text = tasksList[index].name;
                            selectedDate = tasksList[index].date;
                            selectedTime = tasksList[index].time;
                            editIndex = index;
                          });
                          DefaultTabController.of(context)?.animateTo(1);
                        }, child: Icon(Icons.edit)),
                        ElevatedButton(onPressed: ()=>deleteTask(index), child: Icon(Icons.delete)),
                      ],),
                    );
                  },
                ),

            // Add Task
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Enter Task Name'),
                    controller: nameController,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        initialDate: DateTime.now(),
                      );
                      setState(() {});
                    },
                    child: Text(
                      selectedDate == null
                          ? 'Pick Date'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                    },
                    child: Text(
                      selectedTime == null
                          ? 'Pick Time'
                          : '${selectedTime!.hour}:${selectedTime!.minute}',
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () => editIndex == null ? addTask() : editTask(),
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTask() {
    setState(() {
      tasksList.add(
        Tasks(
          name: nameController.text,
          date: this.selectedDate!,
          time: this.selectedTime!,
        ),
      );
    });
    nameController.clear();
    selectedTime = null;
    selectedDate = null;
  }

  void deleteTask(int index)
  {
    setState(() {
      tasksList.removeAt(index);
    });
  }

  void editTask(){
    setState(() {
      tasksList[this.editIndex!] = Tasks(name: nameController.text, date: selectedDate!, time: selectedTime!);

      nameController.clear();
      selectedTime = null;
      selectedDate = null;
    });
  DefaultTabController.of(context)?.animateTo(1);
  }
}

