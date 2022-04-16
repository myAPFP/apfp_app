// Copyright 2022 The myAPFP Authors. All rights reserved.

import '../alert/alert_widget.dart';
import '/components/announcement_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlertsWidget extends StatefulWidget {
  /// The annoucements collection stream.
  late final Stream<QuerySnapshot<Map<String, dynamic>>> announcementsStream;

  AlertsWidget({Key? key, required this.announcementsStream}) : super(key: key);

  @override
  _AlertsWidgetState createState() => _AlertsWidgetState();
}

class _AlertsWidgetState extends State<AlertsWidget> {
  /// Serves as key for the [Scaffold] found in [build].
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// List of previous announcements collected from Firestore.
  List<Padding> previousAnnouncements = [];

  @override
  void initState() {
    super.initState();
    _collectPreviousAnnouncements();
  }

  /// Creates an alert card to be displayed.
  InkWell _makeAlertCard(String alertTitle, String alertDescription) {
    return InkWell(
      key: Key('Alert'),
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AlertWidget(title: alertTitle, description: alertDescription),
          ),
        );
      },
      child:
          AnnouncementWidget(title: alertTitle, description: alertDescription),
    );
  }

  /// Adds padding to an alert card.
  Padding _paddedAlert(InkWell alert) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [Expanded(child: alert)],
      ),
    );
  }

  /// Creates header.
  AutoSizeText _makeHeader(String text) {
    return AutoSizeText(
      text,
      textAlign: TextAlign.start,
      style: FlutterFlowTheme.title1,
    );
  }

  /// Adds padding to a header.
  Padding _paddedHeader(AutoSizeText header) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 24, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: header,
      ),
    );
  }

  /// Adds a previous padded alert card to [previousAnnouncements].
  void addToPrevious(Padding previous) {
    setState(() {
      previousAnnouncements.add(previous);
    });
  }

  /// Fetches previous annoucements from Firestore.
  void _collectPreviousAnnouncements() {
    widget.announcementsStream
        .forEach((QuerySnapshot<Map<String, dynamic>> snapshot) {
      previousAnnouncements.clear();
      snapshot.docs.forEach((QueryDocumentSnapshot element) {
        if ((element['topic'] == 'Alerts') |
            (element['topic'] ==
                FirebaseAuth.instance.currentUser!.displayName!
                    .replaceAll(" ", ""))) {
          addToPrevious(_paddedAlert(
              _makeAlertCard(element['title'], element['description'])));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _paddedHeader(_makeHeader('Previous Announcements')),
                ],
              ),
              Column(
                children: previousAnnouncements,
              )
            ],
          ),
        ),
      ),
    );
  }
}
