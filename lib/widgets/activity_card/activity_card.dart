import 'package:apfp/flutter_flow/flutter_flow_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityCard {
  String? name;
  String? type;
  IconData? icon;
  String? duration;
  String? timestamp;

  Card? _card;

  ActivityCard(
      {String? duration,
      String? type,
      String? name,
      IconData? icon,
      String? timestamp}) {
    this.name = name;
    this.type = type;
    this.icon = icon;
    this.duration = duration;
    this.timestamp = timestamp;
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
          SizedBox(width: 15),
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
                            0.6),
                    child: Text(
                      '$name',
                      style: FlutterFlowTheme.title1,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ))
              ]),
              SizedBox(height: 15),
              Row(children: [
                AutoSizeText.rich(TextSpan(
                    text: 'Type:',
                    style: FlutterFlowTheme.title3Red,
                    children: [
                      TextSpan(
                        text: ' $type',
                        style: FlutterFlowTheme.bodyText1,
                      )
                    ])),
              ]),
              SizedBox(height: 5),
              Row(
                children: [
                  AutoSizeText.rich(TextSpan(
                      text: 'Duration:',
                      style: FlutterFlowTheme.title3Red,
                      children: [
                        TextSpan(
                          text: ' $duration',
                          style: FlutterFlowTheme.bodyText1,
                        )
                      ])),
                ],
              ),
              SizedBox(width: 5),
              AutoSizeText.rich(TextSpan(
                  text: 'Logged at ',
                  style: FlutterFlowTheme.bodyText1,
                  children: [
                    TextSpan(
                      text: timestamp,
                      style: FlutterFlowTheme.title3Red,
                    )
                  ]))
            ],
          ),
        ],
      ),
    );
  }

  Padding paddedActivityCard(BuildContext context) {
    return Padding(
      key: Key('$name $type $duration'),
      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
      child: Container(
        child: _card,
        height: 130,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF54585A)),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
