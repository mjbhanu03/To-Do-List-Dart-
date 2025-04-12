import 'package:assignment2/home/home_with_bottom_nav.dart';
import 'package:assignment2/home/home_with_nav_drawer.dart';
import 'package:assignment2/home/home_with_tab.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Hey There'),),
      body: Center(
        child: Column(
          children: [
            TextButton(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>HomeWithTabs()),
              );
            }, child: Text('Home with Tabs')),

            TextButton(onPressed: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context)=> HomeWithBottomNav())
              );
            }, child: Text('Home with Bottom Nav')),

            TextButton(onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>HomeWithNavDrawer()));
            }, child: Text('Home with Nav Drawer'))
          ],
        ),
      ),
    );
  }
}