import 'package:apfp/welcome/welcome_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'firebase/firestore.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'home/home_widget.dart';
import 'alerts/alerts_widget.dart';
import 'at_home_exercises/at_home_exercises_widget.dart';
import 'activity/activity_widget.dart';

void main() {
  //Locking app to portrait orientation.
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, required this.initialPage}) : super(key: key);

  final int initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int _currentPage = 0;
  late FirebaseMessaging messaging;
  late Stream<QuerySnapshot<Map<String, dynamic>>> announcements;
  List<Widget> pageList = List<Widget>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("alerts");
    announcements = FireStore.getAnnouncements();
    pageList.add(HomeWidget(announcementsStream: announcements));
    pageList.add(AlertsWidget(announcementsStream: announcements));
    pageList.add(AtHomeExercisesWidget());
    pageList.add(ActivityWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(children: pageList, index: _currentPage),
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
        currentIndex: _currentPage,
        selectedItemColor: Color(0xFFBA0C2F),
        unselectedItemColor: FlutterFlowTheme.tertiaryColor,
        onTap: (i) {
          setState(() => _currentPage = i);
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
