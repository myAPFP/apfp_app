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
  final currentUser = FirebaseAuth.instance.currentUser;

  Text _deleteAcctDialogText() {
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

  Text _logoutDialogText() {
    return Text('Are you sure you want to log out?\n\nYour data will be saved.',
        style: TextStyle(fontSize: 20));
  }

  Text _changePasswordDialogText() {
    return Text.rich(TextSpan(
        text: 'Want to change your password?\n\nA link will be sent to:\n\n',
        style: TextStyle(fontSize: 20),
        children: [
          TextSpan(
              text: '${currentUser!.email}',
              style: TextStyle(
                  fontSize: 20, color: FlutterFlowTheme.secondaryColor)),
          TextSpan(
              text: '\n\nwith instructions on how to change your password.',
              style: TextStyle(fontSize: 20))
        ]));
  }

  void _showConfirmationDialog(
      {Text? title, Text? content, Function()? onYesTap}) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('NO',
                style: TextStyle(color: FlutterFlowTheme.primaryColor)),
          ),
          TextButton(
            onPressed: onYesTap,
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
        onPressed: () => _showConfirmationDialog(
            title: Text('Logout'),
            content: _logoutDialogText(),
            onYesTap: () async {
              messaging = FirebaseMessaging.instance;
              messaging.deleteToken();
              await FireAuth.signOut();
              _returnToWelcome();
            }),
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

  Padding _settingsButton({String? text, void Function()? onTap}) {
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
                  Text(text!, style: FlutterFlowTheme.title2),
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
                      'Hello, ${currentUser!.displayName}!',
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
                _showConfirmationDialog(
                    title: Text('Change Password'),
                    content: _changePasswordDialogText(),
                    onYesTap: () {
                      FireAuth.sendResetPasswordLink(
                          email: currentUser!.email!);
                      Navigator.pop(context);
                    });
              }),
          _settingsButton(
              text: "Delete Account",
              onTap: () {
                _showConfirmationDialog(
                    title: Text('Delete Account'),
                    content: _deleteAcctDialogText(),
                    onYesTap: () =>
                        FireAuth.deleteCurrentUser(currentUser!.email!));
              }),
          _logOutButton()
        ],
      ),
    );
  }
}
