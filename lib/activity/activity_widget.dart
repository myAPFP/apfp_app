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
            _headerTextRow('Today\'s Activity'),
            _addPadding(
                height: 120,
                color: Colors.transparent,
                border: Border.all(color: Color(0xFF54585A)),
                borderRadius: BorderRadius.circular(10),
                child: _createActivityCard(
                    icon: Icons.sports_basketball_sharp,
                    duration: "30 min",
                    totalCal: "300",
                    name: "Basketball",
                    type: "Cardio")),
            _addPadding(
                height: 120,
                color: Colors.transparent,
                border: Border.all(color: Color(0xFF54585A)),
                borderRadius: BorderRadius.circular(10),
                child: _createActivityCard(
                    icon: Icons.directions_walk_sharp,
                    duration: "30 min",
                    totalCal: "150",
                    name: "Walking",
                    type: "Cardio")),
            _addPadding(
                height: 80,
                child: null,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: null),
            _addActivityButton(),
            _addPadding(
                height: 80,
                child: null,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: null)
          ],
        ),
      ),
    );
  }

  Row _headerTextRow(String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 15),
          child: Text(
            text,
            style: FlutterFlowTheme.title1.override(
              fontFamily: 'Open Sans',
              color: FlutterFlowTheme.primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Align _align(
      {AlignmentDirectional alignment,
      EdgeInsetsDirectional padding,
      Widget child}) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }

  FFButtonOptions _ffButtonOptions() {
    return FFButtonOptions(
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
    );
  }

  FFButtonWidget _addActivityButton() {
    return FFButtonWidget(
      onPressed: () async {
        setState(() => _loadingButton = true);
        try {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddActivityWidget(),
            ),
          );
        } finally {
          setState(() => _loadingButton = false);
        }
      },
      text: '+ Add New Activity',
      options: _ffButtonOptions(),
      loading: _loadingButton,
    );
  }

  Card _createActivityCard(
      {String duration,
      String totalCal,
      String type,
      String name,
      IconData icon}) {
    return Card(
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
                _align(
                    alignment: AlignmentDirectional(-1.13, 0.04),
                    padding: EdgeInsetsDirectional.all(0),
                    child: Icon(
                      icon,
                      color: Color(0xFF54585A),
                      size: 80,
                    )),
                _align(
                    alignment: AlignmentDirectional(103.56, -0.17),
                    padding: EdgeInsetsDirectional.fromSTEB(100, 20, 0, 0),
                    child: Text(
                      '$duration                       $totalCal cals',
                      style: FlutterFlowTheme.bodyText2.override(
                        fontFamily: 'Open Sans',
                        color: FlutterFlowTheme.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                _align(
                    alignment: AlignmentDirectional(-0.21, 0.31),
                    padding: EdgeInsetsDirectional.fromSTEB(100, 30, 0, 0),
                    child: Text(
                      '$type',
                      style: FlutterFlowTheme.bodyText2.override(
                        fontFamily: 'Open Sans',
                        color: FlutterFlowTheme.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                _align(
                    alignment: AlignmentDirectional(0, -0.58),
                    padding: EdgeInsetsDirectional.fromSTEB(100, 0, 0, 0),
                    child: Text(
                      '$name',
                      style: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Open Sans',
                        color: FlutterFlowTheme.primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding _addPadding(
      {double height,
      BorderRadius borderRadius,
      Color color,
      Border border,
      Widget child}) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
      child: Container(
        child: child,
        height: height,
        decoration: BoxDecoration(
          border: border,
          color: color,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
