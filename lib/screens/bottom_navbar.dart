import 'package:flutter/material.dart';
import 'package:money_manager/screens/Graph.dart';
import 'package:money_manager/screens/homescreen.dart';
import 'package:money_manager/main.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  List<Widget> pages=[HomeScreen(),Graph()];
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueGrey,
        currentIndex: index,
        onTap: (value){
          setState(() {
            index=value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard,),label: "Dashboard"),
          BottomNavigationBarItem(icon:Icon( Icons.auto_graph),label: "Graph"),
        ],
      ),

      body: pages.elementAt(index),

    );
  }
}