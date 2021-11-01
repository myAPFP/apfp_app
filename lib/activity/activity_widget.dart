import '../add_activity/add_activity_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityWidget extends StatefulWidget {
  ActivityWidget({Key key}) : super(key: key);

  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 15),
                  child: Text(
                    'Today\'s Activity',
                    style: FlutterFlowTheme.title1.override(
                      fontFamily: 'Open Sans',
                      color: FlutterFlowTheme.primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFF54585A),
                  ),
                ),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.13, 0.04),
                              child: Icon(
                                Icons.directions_walk_sharp,
                                color: Color(0xFF54585A),
                                size: 80,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(103.56, -0.17),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    100, 20, 0, 0),
                                child: Text(
                                  '30 min                       150 cals',
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Open Sans',
                                    color: FlutterFlowTheme.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.21, 0.31),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    100, 30, 0, 0),
                                child: Text(
                                  'Cardio',
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Open Sans',
                                    color: FlutterFlowTheme.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, -0.58),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    100, 0, 0, 0),
                                child: Text(
                                  'Walking',
                                  style: FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Open Sans',
                                    color: FlutterFlowTheme.primaryColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFF54585A),
                  ),
                ),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.23, 0.36),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    100, 35, 0, 0),
                                child: Text(
                                  'Strength',
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Open Sans',
                                    color: FlutterFlowTheme.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.1, -0.5),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    100, 0, 0, 0),
                                child: Text(
                                  'Basketball',
                                  style: FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Open Sans',
                                    color: FlutterFlowTheme.primaryColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.86, -0.02),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    100, 20, 0, 0),
                                child: Text(
                                  '30 min                       300 cals',
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Open Sans',
                                    color: FlutterFlowTheme.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                              child: Icon(
                                Icons.sports_basketball_sharp,
                                color: Color(0xFF54585A),
                                size: 80,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                setState(() => _loadingButton = true);
                try {
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(milliseconds: 125),
                      reverseDuration: Duration(milliseconds: 125),
                      child: AddActivityWidget(),
                    ),
                  );
                } finally {
                  setState(() => _loadingButton = false);
                }
              },
              text: '+ Add New Activity',
              options: FFButtonOptions(
                width: 250,
                height: 50,
                color: FlutterFlowTheme.secondaryColor,
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Open Sans',
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                elevation: 2,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
              loading: _loadingButton,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
