import '../flutter_flow/flutter_flow_theme.dart';
import '../main.dart';
import 'package:flutter/material.dart';

class AlertWidget extends StatefulWidget {
  AlertWidget({Key? key}) : super(key: key);

  @override
  _AlertWidgetState createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  InkWell _backToList() {
    return InkWell(
      onTap: () async {
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => NavBarPage(initialPage: 'Alerts'),
          ),
          (r) => false,
        );
      },
      child: Text(
        '< Back to Announcements',
        style: FlutterFlowTheme.subtitle2
      ),
    );
  }

  Text _announcementTitle(String text) {
    return Text(
      text,
      style: FlutterFlowTheme.title1,
    );
  }

  Text _announcementParagraph(String text) {
    return Text(
      text,
      style: FlutterFlowTheme.bodyText1,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 25, 15, 0),
              child: _backToList(),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
              child: _announcementTitle("Example Announcement Title"),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
              child: _announcementParagraph(
                  "This is an example paragraph for an announcement. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce lacinia libero ut sapien maximus, vitae viverra nulla iaculis. \n\nUt lacinia ultrices augue, hendrerit faucibus odio venenatis ac. Vivamus aliquet dignissim nunc. Quisque non orci a diam faucibus mollis eget ac magna. Fusce ex urna, interdum nec enim nec, vehicula tempus lacus."),
            )
          ],
        ),
      ),
    );
  }
}
