import 'package:flutter/material.dart';
import 'package:flutter_projects/src/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../providers/index_page.dart';
import '../widgets/body.dart';
import '../widgets/messenger.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key, required this.title});
  // , required this.initialPageIndex
  final String title;
  // final int initialPageIndex;

  @override
  Widget build(BuildContext context) {
    int initialPageIndex = Provider.of<IndexPage>(context).initialPageIndex;
    final ThemeData theme = Theme.of(context);
    final person = Provider.of<Person>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ),
        backgroundColor: Colors.lightBlue,
      ), // AppBar
      body: <Widget>[
        /// Home page
        const HomePageCard(),

        /// Notifications page
        const NotificationsPage(),

        /// Messages page
        const ChatScreen()
      ][initialPageIndex],
      bottomNavigationBar: const NavigationBarWidget(), //initialPageIndex: initialPageIndex,
    );
  }
}
