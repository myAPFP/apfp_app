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
            Row(
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
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFFBDBDBD),
                  width: 2,
                ),
              ),
              child: GridView(
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.black,
                              size: 24,
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Placeholder Announcement 1',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: FlutterFlowTheme.primaryColor,
                              fontSize: 16,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.black,
                              size: 24,
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Placeholder Announcement 2',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: FlutterFlowTheme.primaryColor,
                              fontSize: 16,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.black,
                              size: 24,
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Placeholder Announcement 3',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: FlutterFlowTheme.primaryColor,
                              fontSize: 16,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
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
            ),
            Padding(
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
            )
          ],
        ),
      ),
    );
  }
}
