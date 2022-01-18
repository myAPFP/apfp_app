import 'package:apfp/firebase/fire_auth.dart';
import 'package:apfp/widgets/welcome/welcome_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late FirebaseMessaging messaging;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final userDisplayName = FirebaseAuth.instance.currentUser!.displayName;

  Text dialogText() {
    return Text.rich(TextSpan(
        text: "Are you sure you want to delete your account?\n\nThis will be ",
        style: TextStyle(fontSize: 20),
        children: [
          TextSpan(
              text: 'permanent',
              style: TextStyle(
                  fontSize: 20, color: FlutterFlowTheme.secondaryColor)),
          TextSpan(
              text:
                  ' and all of your data will be deleted.\n\nThe app will now exit.',
              style: TextStyle(fontSize: 20))
        ]));
  }

  void _showDeletionConfirmation() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Account'),
        content: dialogText(),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('NO',
                style: TextStyle(color: FlutterFlowTheme.primaryColor)),
          ),
          TextButton(
            onPressed: () {
              FireAuth.deleteCurrentUser();
            },
            child: const Text('YES',
                style: TextStyle(color: FlutterFlowTheme.secondaryColor)),
          ),
        ],
      ),
    );
  }

  void _returnToWelcome() async {
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeWidget(),
      ),
      (r) => false,
    );
  }

  Padding _logOutButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 40),
      child: FFButtonWidget(
        onPressed: () async {
          messaging = FirebaseMessaging.instance;
          messaging.deleteToken();
          await FireAuth.signOut();
          _returnToWelcome();
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
                      'Hello, $userDisplayName!',
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
                _showDeletionConfirmation();
              }),
          _logOutButton()
        ],
      ),
    );
  }
}
