import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/index_page.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({Key? key}) : super(key: key);

  @override
  _NavigationBarWidgetState createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {

  @override
  Widget build(BuildContext context) {
    final initialPageIndex = Provider.of<IndexPage>(context);
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          initialPageIndex.setInitialPageIndex(index);
        });
      },
      indicatorColor: Colors.amber,
      selectedIndex: initialPageIndex.initialPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Badge(child: Icon(Icons.notifications_sharp)),
          label: 'Notifications',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('2'),
            child: Icon(Icons.messenger_sharp),
          ),
          label: 'Messages',
        ),
      ],
    );
  }
}

/*
BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: 'Perfil',
        ),
      ],
    );
*/
