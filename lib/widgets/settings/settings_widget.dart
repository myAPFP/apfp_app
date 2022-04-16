// Copyright 2022 The myAPFP Authors. All rights reserved.

import 'dart:io';

import '/firebase/fire_auth.dart';

import '../health_app_info/health_app_info.dart';

import '../completed_goals/completed_goals_widget.dart';

import '/util/toasted/toasted.dart';
import '/util/validator/validator.dart';
import '/util/internet_connection/internet.dart';

import '/widgets/welcome/welcome_widget.dart';
import '../set_goals/set_goals_widget.dart';
import '/widgets/confimation_dialog/confirmation_dialog.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  /// The [FirebaseMessaging] entry point.
  late FirebaseMessaging messaging;

  /// [TextEditingController] for [_emailTextField].
  TextEditingController? _emailController;

  /// [TextEditingController] for [_passwordTextField].
  TextEditingController? _passwordController;

  /// Serves as key for the [Scaffold] found in [build].
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// Stores the current [User] if they are currently signed-in, or null if not.
  final currentUser = FirebaseAuth.instance.currentUser;

  /// If the app is being ran on Android, this is set to 'Google Fit'.
  /// Otherwise, this is set to 'Health App'.
  String _platformHealthName = Platform.isAndroid ? 'Google Fit' : 'Health App';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
  }

  /// Returns trimmed text from [_passwordController].
  String _getPassword() {
    return _passwordController!.text.trim();
  }

  /// Returns account deletion warning text.
  Text _deleteAcctDialogText() {
    return Text.rich(TextSpan(
        text: "Are you sure you want to delete your account?\n\nThis will be ",
        style: TextStyle(fontSize: 20),
        children: [
          TextSpan(
              text: 'permanent',
              style: TextStyle(
                  fontSize: 20, color: FlutterFlowTheme.secondaryColor)),
          // ! We are closing app here for now, as calling returnToWelcome() from a
          // ! dialog pop up creates routing issues, causing the app to only return to Home.
          TextSpan(
              text: ' and all of your data will be deleted.\n\n',
              style: TextStyle(fontSize: 20))
        ]));
  }

  /// Returns password change info text.
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

  /// Returns a [TextField] which is used for email address input.
  ///
  /// This [Widget] uses [_emailController] as its [TextEditingController].
  TextField _emailTextField() {
    return ConfirmationDialog.dialogTextField(
        enabled: false,
        kbType: TextInputType.emailAddress,
        hintText: currentUser!.email!,
        contr: _emailController);
  }

  /// Returns a [TextField] which is used for email address input.
  ///
  /// This [Widget] uses [_passwordController] as its [TextEditingController].
  TextField _passwordTextField() {
    return ConfirmationDialog.dialogTextField(
        enabled: true,
        kbType: TextInputType.visiblePassword,
        hintText: 'Enter your password here',
        contr: _passwordController);
  }

  /// Returns a Row that contains an info icon and the text being passed in.
  Row _dialogInfoRow(String text) {
    return Row(
      children: [
        Icon(Icons.info, color: FlutterFlowTheme.secondaryColor),
        SizedBox(width: 10),
        Expanded(child: Text(text, style: TextStyle(fontSize: 20)))
      ],
    );
  }

  /// Displays a log out warning dialog when pressed.
  ///
  /// If the user presses 'Yes', they will be logged out.
  Padding _logOutButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 40),
      child: FFButtonWidget(
        onPressed: () => ConfirmationDialog.showConfirmationDialog(
            context: context,
            title: Text('Logout'),
            content: Text(
                'Are you sure you want to log out?\n\nYour data will be saved.',
                style: TextStyle(fontSize: 20)),
            cancelText: 'No',
            submitText: 'Yes',
            onCancelTap: () => Navigator.pop(context),
            onSubmitTap: () async {
              messaging = FirebaseMessaging.instance;
              messaging.deleteToken();
              await FireAuth.signOut();
              Toasted.showToast("Logged out.");
              WelcomeWidget.logOutToWelcome(context);
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

  /// Creates a button to be displayed in Settings.
  ///
  /// The [title] and [onTap] parameters cannot be null.
  Padding _settingsButton(
      {required String title, required void Function() onTap}) {
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
            width: MediaQuery.of(context).size.width * 0.95,
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
                  Text(title, style: FlutterFlowTheme.title2),
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

  /// Signs in the user and then immediately deletes their account.
  ///
  /// This is called when a user must reauthenticate in order to
  /// delete their account.
  _signInAndDelete() async {
    if (await Internet.isConnected()) {
      await FireAuth.signInUsingEmailPassword(
              email: currentUser!.email!, password: _getPassword())
          .then((value) => FireAuth.deleteUserAccount());
    } else
      Toasted.showToast("Please connect to the Internet.");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.tertiaryColor,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
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
                // _settingsButton(
                //     title: "Sync $_platformHealthName",
                //     onTap: () async {
                //       if (await Permission.activityRecognition
                //           .request()
                //           .isGranted) {
                //         Toasted.showToast(
                //             "$_platformHealthName has been synchronized!");
                //       } else if (await Permission.activityRecognition
                //           .request()
                //           .isPermanentlyDenied) {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => HealthAppInfo()),
                //         );
                //       }
                //     }),
                _settingsButton(
                    title: "Set Daily Goals",
                    onTap: () {
                      SetGoalsWidget.launch(context);
                    }),
                _settingsButton(
                    title: "View Completed Goals",
                    onTap: () {
                      CompletedGoalsWidget.launch(context, mode: "Daily");
                    }),
                _settingsButton(
                    title: "Change Password",
                    onTap: () {
                      ConfirmationDialog.showConfirmationDialog(
                          context: context,
                          title: Text('Change Password'),
                          content: _changePasswordDialogText(),
                          cancelText: 'No',
                          submitText: 'Yes',
                          onCancelTap: () => Navigator.pop(context),
                          onSubmitTap: () {
                            FireAuth.sendResetPasswordLink(
                                email: currentUser!.email!);
                            Navigator.pop(context);
                          });
                    }),
                _settingsButton(
                    title: "Delete Account",
                    onTap: () {
                      ConfirmationDialog.showConfirmationDialog(
                          title: Text('Delete Account'),
                          context: context,
                          content: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _deleteAcctDialogText(),
                                _dialogInfoRow(
                                    'Tap anywhere outside of this dialog box to go back')
                              ]),
                          cancelText: 'No',
                          submitText: 'Yes',
                          onCancelTap: () => Navigator.pop(context),
                          onSubmitTap: () {
                            ConfirmationDialog.showConfirmationDialog(
                                context: context,
                                title: Text('Enter your password to confirm.'),
                                content: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _emailTextField(),
                                    SizedBox(height: 5),
                                    _passwordTextField(),
                                    SizedBox(height: 30),
                                    _dialogInfoRow(
                                        'Tap anywhere outside of this dialog box to go back'),
                                    SizedBox(height: 15),
                                    _dialogInfoRow(
                                        'If you exit, restarting the app will prompt you to login')
                                  ],
                                ),
                                cancelText: 'Exit App',
                                submitText: 'Delete Account',
                                onCancelTap: () {
                                  FireAuth.signOut();
                                  SystemChannels.platform
                                      .invokeMethod('SystemNavigator.pop');
                                },
                                onSubmitTap: () {
                                  if (_getPassword().isNotEmpty) {
                                    if (!Validator.hasProfanity(
                                        _getPassword())) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      // Firebase requires a user to be recently
                                      // signed in before deleting their account
                                      FireAuth.signOut();
                                      _signInAndDelete();
                                    } else
                                      Toasted.showToast(
                                          'Profanity is not allowed.');
                                  } else
                                    Toasted.showToast(
                                        'Please provide a password.');
                                });
                          });
                    }),
                _logOutButton()
              ],
            ),
          ),
        ));
  }
}
