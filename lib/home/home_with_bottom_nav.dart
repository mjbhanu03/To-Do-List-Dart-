import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeWithBottomNav extends StatefulWidget{
  _HomeWithBottomNav createState() => _HomeWithBottomNav();
}

class _HomeWithBottomNav extends State<HomeWithBottomNav>{
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Display Page'),),
    Center(child: Text('Add Page'),)
  ];

  void onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Home with Bottom Nav'),),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Display'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add')
          ]
      ),
    );
  }
}