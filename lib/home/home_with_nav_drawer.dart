import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeWithNavDrawer extends StatefulWidget{
  _HomeWithNavDrawer createState() => _HomeWithNavDrawer();
}

class _HomeWithNavDrawer extends State<HomeWithNavDrawer>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Home with Nav Drawer'),),
      body: Center(
        child: Text('Welcome to page 3'),
      ),
    );
  }
}