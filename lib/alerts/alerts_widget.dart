import '../alert/alert_widget.dart';
import '../components/announcement_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertsWidget extends StatefulWidget {
  AlertsWidget({Key key}) : super(key: key);

  @override
  _AlertsWidgetState createState() => _AlertsWidgetState();
}

class _AlertsWidgetState extends State<AlertsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 50, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: AutoSizeText(
                        'Unread Announcements',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: FlutterFlowTheme.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 125),
                            reverseDuration: Duration(milliseconds: 125),
                            child: AlertWidget(),
                          ),
                        );
                      },
                      child: AnnouncementWidget(),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 50, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: AutoSizeText(
                        'Previous Announcements',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: FlutterFlowTheme.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 125),
                              reverseDuration: Duration(milliseconds: 125),
                              child: AlertWidget(),
                            ),
                          );
                        },
                        child: AnnouncementWidget(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 125),
                              reverseDuration: Duration(milliseconds: 125),
                              child: AlertWidget(),
                            ),
                          );
                        },
                        child: AnnouncementWidget(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 125),
                              reverseDuration: Duration(milliseconds: 125),
                              child: AlertWidget(),
                            ),
                          );
                        },
                        child: AnnouncementWidget(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 125),
                              reverseDuration: Duration(milliseconds: 125),
                              child: AlertWidget(),
                            ),
                          );
                        },
                        child: AnnouncementWidget(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 125),
                              reverseDuration: Duration(milliseconds: 125),
                              child: AlertWidget(),
                            ),
                          );
                        },
                        child: AnnouncementWidget(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 125),
                              reverseDuration: Duration(milliseconds: 125),
                              child: AlertWidget(),
                            ),
                          );
                        },
                        child: AnnouncementWidget(),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
