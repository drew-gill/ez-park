import 'package:ez_park/pages/location_detail_page.dart';

import 'pages/map_view_page.dart';
import 'pages/filter_page.dart';
import 'pages/list_view_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EZ Park',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> screens = [
    MapSample(),
    ListViewPage(),
    FilterPage(),
    LocationDetailPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map View',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List View'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_alt),
            label: 'Filters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_parking),
            label: 'Parking Details',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.blue,
        selectedItemColor: Colors.deepOrange,
        onTap: _onItemTapped,
      ),
    );
  }
}