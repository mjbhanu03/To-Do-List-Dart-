import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeWithBottomNav extends StatefulWidget{
  _HomeWithBottomNav createState() => _HomeWithBottomNav();
}

class _HomeWithBottomNav extends State<HomeWithBottomNav>{
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Home with Bottom Nav'),),
      body: Center(
        child: Text('Welcome to Page 2'),
      ),
    );
  }
}