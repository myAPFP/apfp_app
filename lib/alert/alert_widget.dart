import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertWidget extends StatefulWidget {
  AlertWidget({Key key}) : super(key: key);

  @override
  _AlertWidgetState createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
              child: InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      duration: Duration(milliseconds: 125),
                      reverseDuration: Duration(milliseconds: 125),
                      child: NavBarPage(initialPage: 'Alerts'),
                    ),
                  );
                },
                child: Text(
                  '< Back to Announcements',
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Open Sans',
                    color: FlutterFlowTheme.secondaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
              child: Text(
                'Example Announcement Title',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: FlutterFlowTheme.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
              child: Text(
                'This is an example paragraph for an announcement. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce lacinia libero ut sapien maximus, vitae viverra nulla iaculis. \n\nUt lacinia ultrices augue, hendrerit faucibus odio venenatis ac. Vivamus aliquet dignissim nunc. Quisque non orci a diam faucibus mollis eget ac magna. Fusce ex urna, interdum nec enim nec, vehicula tempus lacus.',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Open Sans',
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
