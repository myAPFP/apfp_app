// Copyright 2022 The myAPFP Authors. All rights reserved.

import '/flutter_flow/flutter_flow_theme.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ActivityCard {
  /// Activity name.
  String? name;

  /// Activity exercise type.
  String? type;

  /// Activity card's icon.
  IconData? icon;

  /// Activity duration.
  String? duration;

  /// Activity timestamp.
  String? timestamp;

  /// Activity card.
  Card? _card;

  /// Special activity timestamp reserved for an imported activity.
  ///
  /// Using this timestamp ensures:
  /// - Only one imported activity card appears, and is updated as needed.
  /// - The imported activity card always appears at the top of the activity 
  /// list.
  static String importedActivityID = "3000-12-${DateTime.now().day}T00:00:00.000";

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

  /// Creates an activity card.
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
            Icon(icon,
                color: timestamp == importedActivityID
                    ? FlutterFlowTheme.secondaryColor
                    : Color(0xFF54585A),
                size: 80),
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
                    child: AutoSizeText(
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
              timestamp == importedActivityID
                  ? AutoSizeText("Logged Today",
                      style: FlutterFlowTheme.bodyText1)
                  : AutoSizeText.rich(TextSpan(
                      text: 'Logged at ',
                      style: FlutterFlowTheme.bodyText1,
                      children: [
                          TextSpan(
                            text: DateFormat.jm()
                                .format(DateTime.parse(timestamp!)),
                            style: FlutterFlowTheme.title3Red,
                          )
                        ]))
            ],
          ),
        ],
      ),
    );
  }

  /// Adds padding to an activity card.
  Padding paddedActivityCard(BuildContext context) {
    return Padding(
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

  @override
  String toString() {
    return '$timestamp $name $type $duration';
  }
}
