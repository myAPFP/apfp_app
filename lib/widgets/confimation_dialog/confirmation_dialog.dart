import 'package:flutter/material.dart';
import 'package:apfp/flutter_flow/flutter_flow_theme.dart';

class ConfirmationDialog {
  static void showConfirmationDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    required Function() onSubmitTap,
    required Function() onCancelTap,
    required String cancelText,
    required String submitText,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
            child: content, scrollDirection: Axis.vertical),
        actions: <Widget>[
          TextButton(
            onPressed: onCancelTap,
            child: Text(cancelText,
                style: TextStyle(color: FlutterFlowTheme.primaryColor)),
          ),
          TextButton(
            onPressed: onSubmitTap,
            child: Text(submitText,
                style: TextStyle(color: FlutterFlowTheme.secondaryColor)),
          ),
        ],
      ),
    );
  }
}