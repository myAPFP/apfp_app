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
              text: '\n\nwith instructions on how to do so.',
              style: TextStyle(fontSize: 20))
        ]));
  }

  void _showConfirmationDialog(
      {required String title,
      required Widget content,
      required Function() onYesTap,
      required String cancelText,
      required String submitText}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
            child: content, scrollDirection: Axis.vertical),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(cancelText,
                style: TextStyle(color: FlutterFlowTheme.primaryColor)),
          ),
          TextButton(
            onPressed: onYesTap,
            child: Text(submitText,
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
            title: 'Logout',
            content: _logoutDialogText(),
            cancelText: 'No',
            submitText: 'Yes',
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

  Padding _settingsButton({String? title, void Function()? onTap}) {
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
                  Text(title!, style: FlutterFlowTheme.title2),
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
      body: SingleChildScrollView(
        child: Column(
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
                title: "Add Activity Tracker",
                onTap: () {
                  print("AAT Tapped!");
                }),
            _settingsButton(
                title: "Set Activity Goals",
                onTap: () {
                  print("SAG Tapped!");
                }),
            _settingsButton(
                title: "Notification Settings",
                onTap: () {
                  print("NS Tapped!");
                }),
            _settingsButton(
                title: "Change Password",
                onTap: () {
                  _showConfirmationDialog(
                      title: 'Change Password',
                      content: _changePasswordDialogText(),
                      cancelText: 'No',
                      submitText: 'Yes',
                      onYesTap: () {
                        FireAuth.sendResetPasswordLink(
                            email: currentUser!.email!);
                        Navigator.pop(context);
                      });
                }),
            _settingsButton(
                title: "Delete Account",
                onTap: () {
                  _showConfirmationDialog(
                      title: 'Delete Account',
                      content: _deleteAcctDialogText(),
                      cancelText: 'No',
                      submitText: 'Yes',
                      onYesTap: () {
                        // Navigator.pop(context);
                        _showConfirmationDialog(
                            title: 'Please sign in to confirm.',
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                    decoration:
                                        InputDecoration(hintText: 'Email')),
                                TextField(
                                    decoration:
                                        InputDecoration(hintText: 'Password'))
                              ],
                            ),
                            cancelText: 'Back',
                            submitText: 'Sign In',
                            onYesTap: () {
                              FireAuth.deleteUserAccount();
                            });
                      });
                }),
            _logOutButton()
          ],
        ),
      ),
    );
  }
}
