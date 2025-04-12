import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeWithTabs extends StatefulWidget{

  _HomeWithTabs createState() => _HomeWithTabs();
}

class _HomeWithTabs extends State<HomeWithTabs>{

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home with Tabs'),
            bottom: TabBar(tabs: [
              Tab(text: 'Display',),
              Tab(icon: Icon(Icons.add),)
            ]),
          ),
          body: TabBarView(children: [
            Center(child: Text('Tab 1'),),
            Center(child: Text('Tab 2'),)
          ]),
        ));
  }
}
