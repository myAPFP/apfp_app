import 'package:apfp/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class ActivityCard {
  String? name;
  String? type;
  IconData? icon;
  String? duration;
  String? totalCal;

  Card? _card;

  ActivityCard({String? duration, String? type, String? name, IconData? icon}) {
    this.name = name;
    this.type = type;
    this.icon = icon;
    this.duration = duration;
    _createActivityCard();
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
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: Color(0xFF54585A), size: 80),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQueryData.fromWindow(
                                    WidgetsBinding.instance!.window)
                                .size
                                .width *
                            0.7),
                    child: Text(
                      '$name',
                      style: FlutterFlowTheme.subtitle1,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ))
              ]),
              Row(children: [
                Text(
                  '$type',
                  style: FlutterFlowTheme.bodyText1,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                )
              ]),
              Row(children: [
                Text(
                  '$duration',
                  style: FlutterFlowTheme.bodyText1,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                )
              ])
            ],
          ),
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
