import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeWithNavDrawer extends StatefulWidget {
  @override
  _HomeWithNavDrawer createState() => _HomeWithNavDrawer();
}

class _HomeWithNavDrawer extends State<HomeWithNavDrawer> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Display Page')),
    Center(child: Text('Add Page')),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home with Nav Drawer')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Text('Menu')),
            ListTile(
              onTap: () {
                Navigator.pop(context); // only close drawer here
                onItemTapped(0);
              },
              title: Text('Display'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                onItemTapped(1);
              },
              title: Text('Add'),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Display'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
        ],
      ),
    );
  }
}
