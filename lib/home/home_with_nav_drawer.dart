import 'package:flutter/material.dart';

class Task {
  String title;
  String description;

  Task(this.title, this.description);
}

class HomeWithNavDrawer extends StatefulWidget {
  @override
  _HomeWithNavDrawerState createState() => _HomeWithNavDrawerState();
}

class _HomeWithNavDrawerState extends State<HomeWithNavDrawer> {
  int _selectedIndex = 0;
  List<Task> tasks = [];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void addTask(String title, String description) {
    setState(() {
      tasks.add(Task(title, description));
    });
  }

  void updateTask(int index, String newTitle, String newDesc) {
    setState(() {
      tasks[index].title = newTitle;
      tasks[index].description = newDesc;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      DisplayPage(tasks: tasks, onDelete: deleteTask, onUpdate: updateTask),
      AddPage(onAdd: addTask),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Center(
                  child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
                ),
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Display'),
                onTap: () {
                  Navigator.pop(context);
                  onItemTapped(0);
                },
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add'),
                onTap: () {
                  Navigator.pop(context);
                  onItemTapped(1);
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(child: pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Display'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
        ],
      ),
    );
  }
}

class AddPage extends StatefulWidget {
  final Function(String, String) onAdd;

  AddPage({required this.onAdd});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Task Title'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: descController,
            decoration: InputDecoration(labelText: 'Task Description'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              widget.onAdd(titleController.text, descController.text);
              titleController.clear();
              descController.clear();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task Added")));
            },
            child: Text('Add Task'),
          ),
        ],
      ),
    );
  }
}

class DisplayPage extends StatefulWidget {
  final List<Task> tasks;
  final Function(int) onDelete;
  final Function(int, String, String) onUpdate;

  DisplayPage({required this.tasks, required this.onDelete, required this.onUpdate});

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  TextEditingController searchController = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    List<Task> filteredTasks = widget.tasks
        .where((task) => task.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Search Task',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                  setState(() => query = '');
                },
              )
                  : null,
            ),
            onChanged: (val) => setState(() => query = val),
          ),
        ),
        Expanded(
          child: filteredTasks.isEmpty
              ? Center(child: Text("No matching tasks"))
              : ListView.builder(
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              final task = filteredTasks[index];
              final actualIndex = widget.tasks.indexOf(task);
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () =>
                          _showUpdateDialog(context, actualIndex, task),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => widget.onDelete(actualIndex),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showUpdateDialog(BuildContext context, int index, Task task) {
    TextEditingController titleCtrl = TextEditingController(text: task.title);
    TextEditingController descCtrl = TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Update Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleCtrl, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: descCtrl, decoration: InputDecoration(labelText: 'Description')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.onUpdate(index, titleCtrl.text, descCtrl.text);
              Navigator.pop(context);
            },
            child: Text("Update"),
          ),
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        ],
      ),
    );
  }
}
