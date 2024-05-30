import 'package:flutter/material.dart';
import 'package:test_project/screens/tabs/first_tab.dart';
import 'package:test_project/screens/tabs/second_tab.dart';
import 'package:test_project/screens/tabs/third_tab.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          title: Text(
            'Playvault',
            style: TextStyle(
              color: Colors.grey[350],
              fontSize: 20,
              fontFamily: 'Arial black',
            ),
          ),
        ),
        backgroundColor: Colors.grey[900], //cor da barra Bar

        body: Column(
          children: [
            TabBar(
              tabs: [
                const Tab(
                  text: "EMPRESA",
                  icon: Icon(
                    Icons.home,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
                const Tab(
                  text: "JOGO",
                  icon: Icon(
                    Icons.sports_esports,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
                const Tab(
                  text: "CHAT",
                  icon: Icon(
                    Icons.chat,
                    color: Colors.blue,
                    size: 30,
                  ),

                  //TextStyle
                ),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                FirstTab(),
                SecondTab(),
                ThirdTab(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
