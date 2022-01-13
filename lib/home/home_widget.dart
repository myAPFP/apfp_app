import 'dart:ffi';

import 'package:apfp/firebase/fire_auth.dart';
import 'package:apfp/firebase/firestore.dart';
import 'package:apfp/flutter_flow/flutter_flow_widgets.dart';
import 'package:apfp/welcome/welcome_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final fireAuth = FireAuth();
  late FirebaseMessaging messaging;
  var titlesList = new List.filled(3, "");

  @override
  void initState() {
    _collectAnnouncements();
    super.initState();
  }

  Padding _signOutButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: FFButtonWidget(
        onPressed: () async {
          messaging = FirebaseMessaging.instance;
          messaging.deleteToken();
          await fireAuth.signOut();
          await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomeWidget(),
            ),
            (r) => false,
          );
        },
        text: 'Sign Out',
        options: FFButtonOptions(
          width: 170,
          height: 50,
          color: Color(0xFFBA0C2F),
          textStyle: FlutterFlowTheme.title2,
          elevation: 2,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: 12,
        ),
      ),
    );
  }

  Row _recentAnnouncementsLabel() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 20),
          child: Text(
            'Recent\nAnnouncements',
            style: FlutterFlowTheme.title1,
          ),
        )
      ],
    );
  }

  Text _announcementText(String text) {
    return Text(
      text,
      style: FlutterFlowTheme.bodyText1,
    );
  }

  Column _announcementTextColumn(String text) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _announcementText(text),
      ],
    );
  }

  Icon _errorIcon() {
    return Icon(
      Icons.error_outline,
      color: Colors.black,
      size: 24,
    );
  }

  Row _announcementRow(String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_errorIcon()],
          ),
        ),
        _announcementTextColumn(text)
      ],
    );
  }

  GridView _announcementGrid(
      String alertOneText, String alertTwoText, String alertThreeText) {
    return GridView(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 10,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        _announcementRow(alertOneText),
        _announcementRow(alertTwoText),
        _announcementRow(alertThreeText)
      ],
    );
  }

  Container _announcements(
      String alertOneText, String alertTwoText, String alertThreeText) {
    return Container(
      key: Key('Home.announcements'),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFBDBDBD),
          width: 2,
        ),
      ),
      child: _announcementGrid(alertOneText, alertTwoText, alertThreeText),
    );
  }

  void _collectAnnouncements() async {
    int index = 0;
    final fireStore = FireStore();
    await fireStore
        .getAnnouncements(limit: 3)
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs
        ..forEach((element) {
          String title = element['title'];
          setState(() {
            titlesList[index] = title;
          });
          index++;
        });
    });
  }

  Padding _activityLabel() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 75, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Text('Today\'s Activity', style: FlutterFlowTheme.title1),
          )
        ],
      ),
    );
  }

  Padding _activityGUI() {
    return Padding(
      key: Key('Home.activityGUI'),
      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Color(0xFFBDBDBD),
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
          child: Text(
            'This is placeholder text for the graphical activity interface that has yet to be created. ',
            style: FlutterFlowTheme.bodyText1,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _recentAnnouncementsLabel(),
            _announcements(titlesList[0], titlesList[1], titlesList[2]),
            _activityLabel(),
            _activityGUI(),
            // TODO: Find a place for this sign out button
            // TODO: Maybe make a settings screen?
            _signOutButton()
          ],
        ),
      ),
    );
  }
}
