import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minpro_gani/core/bloc/bloc.dart';
import 'package:minpro_gani/core/services/services.dart';
import 'package:minpro_gani/list_users.dart';
import 'package:minpro_gani/new_user.dart';

import 'about.dart';

/// Flutter code sample for [BottomNavigationBar].

void main() => runApp(const DashboardNavigation());

class DashboardNavigation extends StatelessWidget {
  const DashboardNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DashboardNavigationBar(),
    );
  }
}

class DashboardNavigationBar extends StatefulWidget {
  const DashboardNavigationBar({super.key});

  @override
  State<DashboardNavigationBar> createState() => _DashboardNavigationBarState();
}

class _DashboardNavigationBarState extends State<DashboardNavigationBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[
    BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(ProfileService()),
      child: const ListUsersView(),
    ),
    BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(ProfileService()),
      child: const NewUser(),
    ),
    const AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_sharp),
            label: '+ New',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
