import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            recentAnnouncementsLabel(),
            announcements("Alert 1", "Alert 2", "Alert 3"),
            activityLabel(),
            activityGUI()
          ],
        ),
      ),
    );
  }

  Row recentAnnouncementsLabel() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 20),
          child: Text(
            'Recent\nAnnouncements',
            style: FlutterFlowTheme.title1.override(
              fontFamily: 'Open Sans',
              color: FlutterFlowTheme.primaryColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Text announcementText(String text) {
    return Text(
      text,
      style: FlutterFlowTheme.bodyText1.override(
        fontFamily: 'Open Sans',
        color: FlutterFlowTheme.primaryColor,
        fontSize: 16,
      ),
    );
  }

  Column announcementTextColumn(String text) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        announcementText(text),
      ],
    );
  }

  Icon errorIcon() {
    return Icon(
      Icons.error_outline,
      color: Colors.black,
      size: 24,
    );
  }

  Row announcementRow(String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [errorIcon()],
          ),
        ),
        announcementTextColumn(text)
      ],
    );
  }

  GridView announcementGrid(
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
        announcementRow(alertOneText),
        announcementRow(alertTwoText),
        announcementRow(alertThreeText)
      ],
    );
  }

  Container announcements(
      String alertOneText, String alertTwoText, String alertThreeText) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFBDBDBD),
          width: 2,
        ),
      ),
      child: announcementGrid(alertOneText, alertTwoText, alertThreeText),
    );
  }

  Padding activityLabel() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 75, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Text(
              'Today\'s Activity',
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Open Sans',
                color: FlutterFlowTheme.primaryColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding activityGUI() {
    return Padding(
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
            style: FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Open Sans',
              color: FlutterFlowTheme.primaryColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
