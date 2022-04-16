// Copyright 2022 The myAPFP Authors. All rights reserved.

import '/firebase/fire_auth.dart';

import '../welcome/welcome_widget.dart';

import '/util/toasted/toasted.dart';
import '/util/validator/validator.dart';

import '/widgets/confimation_dialog/confirmation_dialog.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';

class EmailNotConfirmedWidget extends StatefulWidget {
  /// The user's email address.
  final String? email;

  EmailNotConfirmedWidget({Key? key, this.email}) : super(key: key);

  @override
  _EmailNotConfirmedWidgetState createState() =>
      _EmailNotConfirmedWidgetState();
}

class _EmailNotConfirmedWidgetState extends State<EmailNotConfirmedWidget> {
  /// Controls the [CircularProgressIndicator] loading animation of a button.
  bool _loadingButton = false;

  /// [TextEditingController] for the textfield within [_showEmailDialog].
  TextEditingController? _dialogEmailController;

  /// Serves as key for the [Scaffold] found in [build].
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// Returns text taken from [_dialogEmailController].
  String _getDialogEmail() {
    return _dialogEmailController!.text.trim().toLowerCase();
  }

  @override
  void initState() {
    super.initState();
    _dialogEmailController = TextEditingController();
    _dialogEmailController!.text = widget.email != null ? widget.email! : "";
  }

  @override
  void dispose() {
    super.dispose();
    _dialogEmailController!.dispose();
  }

  /// Warning message shown to user.
  Padding _contextMessage() {
    return Padding(
      key: Key('Email.contextMessage'),
      padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 100,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.tertiaryColor,
            ),
            child: Text(
              'You won\'t be able to log in until your email address is verified.' +
                  '\n\nPlease check your email account for a verification link before logging in.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: FlutterFlowTheme.primaryColor),
            ),
          )
        ],
      ),
    );
  }

  /// Displays a [ConfirmationDialog] allowing a user to enter their email.
  void _showEmailDialog(
      {String? title, String? contentText, Function()? onSubmitTap}) {
    ConfirmationDialog.showConfirmationDialog(
        context: context,
        title: Text(title!),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(contentText!, style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ConfirmationDialog.dialogTextField(
                enabled: true,
                kbType: TextInputType.emailAddress,
                hintText: 'Enter your email here',
                contr: _dialogEmailController)
          ],
        ),
        onSubmitTap: onSubmitTap!,
        onCancelTap: () => Navigator.pop(context),
        cancelText: "Back",
        submitText: "Send");
  }

  /// Resends a verification email to the email address provided by the user.
  Padding _resendEmailButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FFButtonWidget(
            key: Key('LogIn.resendEmailButton'),
            onPressed: () async {
              _showEmailDialog(
                  title: 'Resend Email Verification',
                  contentText: 'A new verification email will be sent to:',
                  onSubmitTap: () {
                    if (Validator.isValidEmail(_getDialogEmail())) {
                      FireAuth.reSendEmailVerification();
                      Navigator.pop(context);
                    } else
                      Toasted.showToast('Please provide a valid email address');
                  });
            },
            text: 'Resend Email Verification',
            options: FFButtonOptions(
              width: 250,
              height: 50,
              color: Color(0xFFBA0C2F),
              textStyle: FlutterFlowTheme.title2,
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: 12,
            ),
            loading: _loadingButton,
          )
        ],
      ),
    );
  }

  /// Returns the user to the Welcome screen.
  Padding _returnToWelcomeButton() {
    return Padding(
      key: Key('Email.returnHomeButton'),
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FFButtonWidget(
            onPressed: () async {
              setState(() => _loadingButton = true);
              try {
                await Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    duration: Duration(milliseconds: 125),
                    reverseDuration: Duration(milliseconds: 125),
                    child: WelcomeWidget(),
                  ),
                );
              } finally {
                setState(() => _loadingButton = false);
              }
            },
            text: 'Back to Home',
            options: FFButtonOptions(
              width: 250,
              height: 50,
              color: Color(0xFFBA0C2F),
              textStyle: FlutterFlowTheme.title2,
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: 12,
            ),
            loading: _loadingButton,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _contextMessage(),
            _resendEmailButton(),
            _returnToWelcomeButton()
          ],
        ),
      ),
    );
  }
}
