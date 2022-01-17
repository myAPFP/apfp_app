import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Padding _logOutButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 40),
      child: FFButtonWidget(
        onPressed: () {
          print('Button pressed ...');
        },
        text: 'Log Out',
        options: FFButtonOptions(
          width: 130,
          height: 50,
          color: FlutterFlowTheme.secondaryColor,
          textStyle: FlutterFlowTheme.title2,
          elevation: 2,
          borderSide: BorderSide(
            color: FlutterFlowTheme.secondaryColor,
          ),
          borderRadius: 8,
        ),
      ),
    );
  }

  Padding _settingsButton({String text = "", void Function()? onTap}) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 60,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 4, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(text, style: FlutterFlowTheme.title2),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: FlutterFlowTheme.tertiaryColor,
                    size: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 160,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.secondaryColor,
            ),
            child: Align(
              alignment: AlignmentDirectional(0.05, 0.55),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Text(
                      'Hello, [First Name]!',
                      style: FlutterFlowTheme.title2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          _settingsButton(
              text: "Add Activity Tracker",
              onTap: () {
                print("AAT Tapped!");
              }),
          _settingsButton(
              text: "Set Activity Goals",
              onTap: () {
                print("SAG Tapped!");
              }),
          _settingsButton(
              text: "Notification Settings",
              onTap: () {
                print("NS Tapped!");
              }),
          _settingsButton(
              text: "Change Password",
              onTap: () {
                print("CP Tapped!");
              }),
          _settingsButton(
              text: "Delete Account",
              onTap: () {
                print("DA Tapped!");
              }),
              _logOutButton()
        ],
      ),
    );
  }
}
