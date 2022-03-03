import 'package:apfp/widgets/settings/settings_widget.dart';
import 'package:apfp/widgets/welcome/welcome_widget.dart';
import 'package:apfp/util/internet_connection/internet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'firebase/firestore.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'widgets/home/home_widget.dart';
import 'widgets/alerts/alerts_widget.dart';
import 'widgets/at_home_exercises/at_home_exercises_widget.dart';
import 'widgets/activity/activity_widget.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
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

class _NavBarPageState extends State<NavBarPage> with WidgetsBindingObserver {
  int _currentPage = 0;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> userActivity;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> userHealth;
  late FirebaseMessaging messaging;
  Stream<QuerySnapshot> ytPlaylistStream = FireStore.getYTPlaylistIDs();
  Stream<QuerySnapshot> ytVideoStream = FireStore.getYTVideoUrls();
  Stream<QuerySnapshot<Map<String, dynamic>>> announcements =
      FireStore.getAnnouncements();
  List<Widget> pageList = List<Widget>.empty(growable: true);
  bool _internetConnected = true;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    userActivity = connectActivityDocument();
    userHealth = connectHealthDocument();
    _currentPage = widget.initialPage;
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("alerts");
    pageList.add(HomeWidget(
        announcementsStream: announcements,
        activityStream: userActivity,
        healthStream: userHealth));
    pageList.add(AlertsWidget(announcementsStream: announcements));
    pageList.add(AtHomeExercisesWidget(
        playlistStream: ytPlaylistStream, videoStream: ytVideoStream));
    pageList.add(ActivityWidget(activityStream: userActivity));
    pageList.add(SettingsWidget());
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    _connectivitySubscription.cancel();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> connectActivityDocument() {
    Future<DocumentSnapshot<Map<String, dynamic>>> userDocumentReference =
        FirebaseFirestore.instance
            .collection('activity')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .get();
    userDocumentReference.then((value) {
      if (!value.exists) {
        FireStore.createUserActivityDocument();
      }
    });
    return FireStore.createUserActivityStream();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> connectHealthDocument() {
    Future<DocumentSnapshot<Map<String, dynamic>>> userDocumentReference =
        FirebaseFirestore.instance
            .collection('health')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .get();
    userDocumentReference.then((value) {
      if (!value.exists) {
        FireStore.createHealthDocument();
      }
    });
    return FireStore.createHealthDocStream();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
    if (_connectionStatus == ConnectivityResult.none) {
      _internetConnected = false;
      showSnackbar(context, "Please check your Internet connection",
          duration: Duration(days: 365), noConnection: true);
    } else if (_connectionStatus == ConnectivityResult.wifi ||
        _connectionStatus == ConnectivityResult.mobile) {
      if (!_internetConnected) {
        await checkInternetConnection();
      }
    }
  }

  Future<void> checkInternetConnection() async {
    if (await Internet.isConnected()) {
      _internetConnected = true;
      showSnackbar(context, "Connected to the Internet");
      initState();
    } else {
      _internetConnected = false;
      showSnackbar(context, "Please check your Internet connection",
          duration: Duration(days: 365), noConnection: true);
    }
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
            label: 'Activity',
            tooltip: 'My Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 40),
            label: 'Settings',
            tooltip: 'Settings',
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
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
