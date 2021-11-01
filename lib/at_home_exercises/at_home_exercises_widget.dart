import '../exercise_video/exercise_video_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AtHomeExercisesWidget extends StatefulWidget {
  AtHomeExercisesWidget({Key key}) : super(key: key);

  @override
  _AtHomeExercisesWidgetState createState() => _AtHomeExercisesWidgetState();
}

class _AtHomeExercisesWidgetState extends State<AtHomeExercisesWidget> {
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 24, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'At-Home Exercises',
                    style: FlutterFlowTheme.title1.override(
                      fontFamily: 'Open Sans',
                      color: FlutterFlowTheme.primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 4, 24, 24),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'The following videos are some exercises you could try at home. They range in exersise type, difficulty and duration.',
                      style: FlutterFlowTheme.bodyText2.override(
                        fontFamily: 'Open Sans',
                        color: FlutterFlowTheme.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 8, 10, 0),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 125),
                            reverseDuration: Duration(milliseconds: 125),
                            child: ExerciseVideoWidget(),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: FlutterFlowTheme.primaryColor,
                          ),
                        ),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-0.1, -0.5),
                                      child: Text(
                                        'High Intensity Interval Training',
                                        style:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(2.64, 0.55),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Text(
                                          'Cardiovascular\nDifficulty: Intermediate',
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Open Sans',
                                            color:
                                                FlutterFlowTheme.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: AlignmentDirectional(0.05, 0),
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFF95A1AC),
                                    size: 28,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 8, 10, 0),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 125),
                            reverseDuration: Duration(milliseconds: 125),
                            child: ExerciseVideoWidget(),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: FlutterFlowTheme.primaryColor,
                          ),
                        ),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-0.1, -0.5),
                                      child: Text(
                                        'High Intensity Interval Training',
                                        style:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(2.64, 0.55),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Text(
                                          'Cardiovascular\nDifficulty: Intermediate',
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Open Sans',
                                            color:
                                                FlutterFlowTheme.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: AlignmentDirectional(0.05, 0),
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFF95A1AC),
                                    size: 28,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 8, 10, 0),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseVideoWidget(),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: FlutterFlowTheme.primaryColor,
                          ),
                        ),
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 125),
                                reverseDuration: Duration(milliseconds: 125),
                                child: ExerciseVideoWidget(),
                              ),
                            );
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 0, 0),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-0.1, -0.5),
                                        child: Text(
                                          'High Intensity Interval Training',
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Open Sans',
                                            color:
                                                FlutterFlowTheme.primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(2.64, 0.55),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: Text(
                                            'Cardiovascular\nDifficulty: Intermediate',
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Open Sans',
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: AlignmentDirectional(0.05, 0),
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: Color(0xFF95A1AC),
                                      size: 28,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 8, 10, 0),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseVideoWidget(),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: FlutterFlowTheme.primaryColor,
                          ),
                        ),
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExerciseVideoWidget(),
                              ),
                            );
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 0, 0),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-0.1, -0.5),
                                        child: Text(
                                          'High Intensity Interval Training',
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Open Sans',
                                            color:
                                                FlutterFlowTheme.primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(2.64, 0.55),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: Text(
                                            'Cardiovascular\nDifficulty: Intermediate',
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Open Sans',
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: AlignmentDirectional(0.05, 0),
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: Color(0xFF95A1AC),
                                      size: 28,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
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
    );
  }
}
