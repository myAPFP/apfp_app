// Copyright 2022 The myAPFP Authors. All rights reserved.

import 'dart:async';
import 'dart:developer' as developer;

import 'firebase/firestore.dart';

import 'service/notification_service.dart';

import 'util/internet_connection/internet.dart';

import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/flutter_flow_theme.dart';

import 'widgets/home/home_widget.dart';
import 'widgets/alerts/alerts_widget.dart';
import 'widgets/welcome/welcome_widget.dart';
import 'widgets/settings/settings_widget.dart';
import 'widgets/activity/activity_widget.dart';
import 'widgets/completed_goals/completed_goals_widget.dart';
import 'widgets/at_home_exercises/at_home_exercises_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
  ));
  NotificationService.init();
  runApp(MyApp());
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, required this.initialPage}) : super(key: key);

  /// The initial page's index.
  final int initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> with WidgetsBindingObserver {
  /// Current pages index.
  int _currentPage = 0;

  /// The user's goal document stream.
  late Stream<DocumentSnapshot<Map<String, dynamic>>> userGoals;

  /// The user's activity document stream.
  late Stream<DocumentSnapshot<Map<String, dynamic>>> userActivity;

  /// The [FirebaseMessaging] entry point.
  late FirebaseMessaging messaging;

  /// The APFP YouTube url collection stream.
  Stream<QuerySnapshot> ytVideoStream = FireStore.getYTVideoUrls();

  /// The APFP YouTube playlist id collection stream.
  Stream<QuerySnapshot> ytPlaylistStream = FireStore.getYTPlaylistIDs();

  /// The announcements collection stream.
  Stream<QuerySnapshot<Map<String, dynamic>>> announcements =
      FireStore.getAnnouncements();

  /// A list of pages to be used in the Nav bar.
  List<Widget> pageList = [];

  /// Indicates if the app is in foreground.
  bool _isInForeground = true;

  /// Indicates if the user's device is connected to the internet.
  bool _internetConnected = true;

  /// Current connection status of user's device.
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  /// Discover network connectivity configurations:
  /// Distinguish between WI-FI and cellular, check WI-FI status and more.
  final Connectivity _connectivity = Connectivity();

  /// Connection subscription.
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    userGoals = _goalStream();
    userActivity = _activityStream();
    _initPageList();
    _initConnectivity();
    _initFirebaseMessaging();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    WidgetsBinding.instance!.addObserver(this);
    _listenToNotifications();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    _connectivitySubscription.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _isInForeground = true;
      _initConnectivity();
    } else if (state == AppLifecycleState.paused) {
      _isInForeground = false;
    }
  }

  /// Adds all Widgets to [pageList] to be displayed in the Nav bar.
  void _initPageList() {
    pageList.add(HomeWidget(
        announcementsStream: announcements,
        activityStream: userActivity,
        goalStream: userGoals));
    pageList.add(AlertsWidget(announcementsStream: announcements));
    pageList.add(AtHomeExercisesWidget(
        playlistStream: ytPlaylistStream, videoStream: ytVideoStream));
    pageList.add(ActivityWidget(activityStream: userActivity));
    pageList.add(SettingsWidget());
  }

  /// Subscribes the user to necessary Firebase messaging topics.
  void _initFirebaseMessaging() {
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("Alerts");
    messaging.subscribeToTopic(
        FirebaseAuth.instance.currentUser!.displayName!.replaceAll(" ", ""));
  }

  /// Listens for local notification clicks.
  void _listenToNotifications() {
    NotificationService.onNotifications.stream.listen(_onClickNotification);
  }

  /// Launches the Completed Goals screen upon notification click.
  void _onClickNotification(String? payload) {
    CompletedGoalsWidget.launch(context, mode: payload!);
  }

  /// Returns the user's activity stream.
  ///
  /// If there is no activity document present in Firestore,
  /// a default one is created and its stream is returned.
  Stream<DocumentSnapshot<Map<String, dynamic>>> _activityStream() {
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

  /// Returns the user's goal stream.
  ///
  /// If there is no goal document present in Firestore,
  /// a default one is created and its stream is returned.
  Stream<DocumentSnapshot<Map<String, dynamic>>> _goalStream() {
    Future<DocumentSnapshot<Map<String, dynamic>>> userDocumentReference =
        FirebaseFirestore.instance
            .collection('goals')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .get();
    userDocumentReference.then((value) {
      if (!value.exists) {
        FireStore.createGoalDocument();
      }
    });
    return FireStore.createGoalDocStream();
  }

  /// Initializes [_connectivity].
  Future<void> _initConnectivity() async {
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

  /// Updates [_connectionStatus] and [_internetConnected] based on
  /// the devices current connection.
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
    if (_isInForeground) {
      if (_connectionStatus == ConnectivityResult.none) {
        _internetConnected = false;
        showSnackbar(context, "Please check your Internet connection",
            duration: Duration(days: 365), noConnection: true);
      } else if (_connectionStatus == ConnectivityResult.wifi ||
          _connectionStatus == ConnectivityResult.mobile) {
        if (!_internetConnected) {
          await _checkInternetConnection();
        }
      }
    }
  }

  /// Checks if the device is connected to the internet.
  Future<void> _checkInternetConnection() async {
    if (await Internet.isConnected()) {
      _internetConnected = true;
      showSnackbar(context, "Connected to the Internet");
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
            label: 'At-Home Exercises',
            tooltip: 'Exercises',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.heartbeat,
              size: 40,
            ),
            label: 'Activity',
            tooltip: "Today's Activity",
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
