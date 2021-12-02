import 'package:apfp/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class ActivityCard {
  String? name;
  String? type;
  IconData? icon;
  String? duration;
  String? totalCal;

  Card? _card;

  ActivityCard(
      {String? duration,
      String? totalCal,
      String? type,
      String? name,
      IconData? icon}) {
    this.name = name;
    this.type = type;
    this.icon = icon;
    this.duration = duration;
    this.totalCal = totalCal;
    _createActivityCard();
  }

  Align _align(
      {required AlignmentDirectional alignment,
      required EdgeInsetsDirectional padding,
      Widget? child}) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }

  void _createActivityCard() {
    _card = Card(
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
                      style: FlutterFlowTheme.bodyText1,
                    )),
                _align(
                    alignment: AlignmentDirectional(-0.21, 0.31),
                    padding: EdgeInsetsDirectional.fromSTEB(100, 30, 0, 0),
                    child: Text(
                      '$type',
                      style: FlutterFlowTheme.bodyText1,
                    )),
                _align(
                    alignment: AlignmentDirectional(0, -0.58),
                    padding: EdgeInsetsDirectional.fromSTEB(100, 0, 0, 0),
                    child: Text(
                      '$name',
                      style: FlutterFlowTheme.subtitle1,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding paddedActivityCard() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
      child: Container(
        child: _card,
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF54585A)),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
