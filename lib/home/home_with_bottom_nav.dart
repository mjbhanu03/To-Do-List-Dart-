import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: HomeWithBottomNav()));

class Task {
  String name;
  String description;

  Task(this.name, this.description);
}

class HomeWithBottomNav extends StatefulWidget {
  @override
  _HomeWithBottomNavState createState() => _HomeWithBottomNavState();
}

class _HomeWithBottomNavState extends State<HomeWithBottomNav> {
  List<Task> taskList = [];
  int selectedIndex = 0;
  int? editingIndex;
  String searchQuery = '';

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final searchController = TextEditingController();

  void addOrUpdateTask() {
    final name = nameController.text.trim();
    final desc = descController.text.trim();

    if (name.isEmpty || desc.isEmpty) return;

    setState(() {
      if (editingIndex != null) {
        taskList[editingIndex!] = Task(name, desc);
        editingIndex = null;
      } else {
        taskList.add(Task(name, desc));
      }
      nameController.clear();
      descController.clear();
    });
  }

  void deleteTask(int index) {
    setState(() {
      taskList.removeAt(index);
    });
  }

  void editTask(int index) {
    setState(() {
      editingIndex = index;
      nameController.text = taskList[index].name;
      descController.text = taskList[index].description;
      selectedIndex = 1;
    });
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DisplayPage(
        taskList: taskList,
        onEdit: editTask,
        onDelete: deleteTask,
        searchQuery: searchQuery,
        searchController: searchController,
        onSearchChanged: updateSearchQuery,
      ),
      AddPage(
        nameController: nameController,
        descController: descController,
        onSubmit: addOrUpdateTask,
        isEditing: editingIndex != null,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('To Do List')),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Display'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
        ],
      ),
    );
  }
}

class DisplayPage extends StatelessWidget {
  final List<Task> taskList;
  final Function(int) onDelete;
  final Function(int) onEdit;
  final String searchQuery;
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const DisplayPage({
    required this.taskList,
    required this.onDelete,
    required this.onEdit,
    required this.searchQuery,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filteredTasks = taskList.where((task) {
      final nameMatch = task.name.toLowerCase().contains(searchQuery);
      final descMatch = task.description.toLowerCase().contains(searchQuery);
      return nameMatch || descMatch;
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              labelText: 'Search Task',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: filteredTasks.isEmpty
              ? Center(child: Text('No tasks found.'))
              : ListView.builder(
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              final task = filteredTasks[index];
              final originalIndex = taskList.indexOf(task);
              return ListTile(
                title: Text(task.name),
                subtitle: Text(task.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => onEdit(originalIndex),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => onDelete(originalIndex),
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
}

class AddPage extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descController;
  final VoidCallback onSubmit;
  final bool isEditing;

  const AddPage({
    required this.nameController,
    required this.descController,
    required this.onSubmit,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Task Name'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: descController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onSubmit,
            child: Text(isEditing ? 'Update Task' : 'Add Task'),
          ),
        ],
      ),
    );
  }
}
