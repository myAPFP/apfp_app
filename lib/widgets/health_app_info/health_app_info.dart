// Copyright 2022 The myAPFP Authors. All rights reserved.

import 'dart:io';
import '/main.dart';
import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class HealthAppInfo extends StatefulWidget {
  const HealthAppInfo({Key? key}) : super(key: key);

  @override
  _HealthAppInfoState createState() => _HealthAppInfoState();
}

class _HealthAppInfoState extends State<HealthAppInfo> {
  /// Serves as key for the [Scaffold] found in [build].
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// If the app is being ran on Android, this is set to 'Google Fit'.
  /// Otherwise, this is set to 'Google Fit and Apple Health'.
  final _healthAppName =
      Platform.isAndroid ? "Google Fit" : "Google Fit and Apple Health";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 25, 15, 0),
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavBarPage(initialPage: 1),
                      ),
                    );
                  },
                  child: Text('< Back to Settings',
                      style: FlutterFlowTheme.subtitle2),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                child: Text('Connecting to $_healthAppName',
                    style: FlutterFlowTheme.title1),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                child: Text(
                    '$_healthAppName can be synchronized to the app using your system settings.\n\n' +
                        'This will allow you to connect an activity tracker, such as Fitbit, to the myAPFP app.\n\n' +
                        'To allow or remove access, go to:\n\nSettings ->  Privacy ->  Permission manager -> Physical activity ->  myAPFP\n',
                    style: FlutterFlowTheme.bodyText1),
              ),
              Align(
                alignment: AlignmentDirectional(0.05, 0),
                child: Image.asset(
                  'assets/images/sync_health_app.png',
                  width: MediaQuery.of(context).size.width * 0.6,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: Text(
                    'From here, choose whether you allow or  don\'t allow myAPFP to access your physical activity data.',
                    style: FlutterFlowTheme.bodyText1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
