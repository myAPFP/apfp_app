// Copyright 2022 The myAPFP Authors. All rights reserved.

import '../../util/platform/device_platform.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';

class HealthAppInfo extends StatefulWidget {
  const HealthAppInfo({Key? key}) : super(key: key);

  @override
  _HealthAppInfoState createState() => _HealthAppInfoState();
}

class _HealthAppInfoState extends State<HealthAppInfo> {
  /// Serves as key for the [Scaffold] found in [build].
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                  child: Text('< Back', style: FlutterFlowTheme.subtitle2),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                child: Text('Connecting to ${DevicePlatform.platformHealthName}',
                    style: FlutterFlowTheme.title1),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                child: Text(
                    'Activity information from fitness trackers can be imported to myAPFP via the Refresh icon on the Activity page. If permissions are initially denied, ${DevicePlatform.platformHealthName} can be synchronized to the app using your system settings.\n\n' +
                        'This will allow you to connect a linked activity tracker, such as Fitbit, to the myAPFP app.\n\n' +
                       DevicePlatform.settingsPath,
                    style: FlutterFlowTheme.bodyText1),
              ),
              Align(
                alignment: AlignmentDirectional(0.05, 0),
                child: Image.asset(
                  DevicePlatform.imagePath,
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
              SizedBox(height: 5)
            ],
          ),
        ),
      ),
    );
  }
}
