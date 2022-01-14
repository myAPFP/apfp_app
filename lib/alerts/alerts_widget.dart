import 'package:apfp/firebase/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../alert/alert_widget.dart';
import '../components/announcement_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AlertsWidget extends StatefulWidget {
  late Future<QuerySnapshot<Object?>> alertsDB;
  AlertsWidget({Key? key, required this.alertsDB}) : super(key: key);

  @override
  _AlertsWidgetState createState() => _AlertsWidgetState();
}

class _AlertsWidgetState extends State<AlertsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Padding> unReadAnnouncements = [];
  List<Padding> previousAnnouncements = [];

  InkWell _makeAlert(String alertTitle, String alertDescription) {
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

  AutoSizeText _makeHeader(String text) {
    return AutoSizeText(
      text,
      textAlign: TextAlign.start,
      style: FlutterFlowTheme.title1,
    );
  }

  Padding _paddedHeader(AutoSizeText header) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(25, 50, 0, 0),
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

  void addToUnRead(Padding unRead) {
    setState(() {
      unReadAnnouncements.add(unRead);
    });
  }

  void addToPrevious(Padding previous) {
    setState(() {
      previousAnnouncements.add(previous);
    });
  }

  void _collectAnnouncements() {
    widget.alertsDB.then((QuerySnapshot querySnapshot) {
      querySnapshot.docs
        ..forEach((element) {
          String title = element['title'];
          String description = element['description'];
          addToPrevious(_paddedAlert(_makeAlert(title, description)));
        });
    });
  }

  @override
  void initState() {
    super.initState();
    _collectAnnouncements();
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
              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [_paddedHeader(_makeHeader('Unread Announcements'))],
              // ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: unReadAnnouncements,
              ),
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
