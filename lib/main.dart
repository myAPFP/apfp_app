import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'home/home_widget.dart';
import 'alerts/alerts_widget.dart';
import 'at_home_exercises/at_home_exercises_widget.dart';
import 'activity/activity_widget.dart';

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, required this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'Home';
  late FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("alerts");
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'Home': HomeWidget(),
      'Alerts': AlertsWidget(),
      'AtHomeExercises': AtHomeExercisesWidget(),
      'Activity': ActivityWidget(),
    };
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        key: Key('BottomNavBar'),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              size: 48,
            ),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 40,
            ),
            label: 'Alerts',
            tooltip: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.dumbbell,
              size: 35,
            ),
            label: 'Exercises',
            tooltip: 'Exercises',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.heartbeat,
              size: 40,
            ),
            label: 'My Activity',
            tooltip: 'My Activity',
          )
        ],
        backgroundColor: Color(0xFF54585A),
        currentIndex: tabs.keys.toList().indexOf(_currentPage),
        selectedItemColor: Color(0xFFBA0C2F),
        unselectedItemColor: FlutterFlowTheme.tertiaryColor,
        onTap: (i) {
          setState(() => _currentPage = tabs.keys.toList()[i]);
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
