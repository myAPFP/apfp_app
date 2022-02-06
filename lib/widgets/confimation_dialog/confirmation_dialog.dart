import 'package:flutter/material.dart';
import 'package:apfp/flutter_flow/flutter_flow_theme.dart';

class ConfirmationDialog {
  static void showConfirmationDialog({
    required BuildContext context,
    required Widget title,
    required Widget content,
    required Function() onSubmitTap,
    required Function() onCancelTap,
    required String cancelText,
    required String submitText,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: title,
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

  static TextField dialogTextField(
      {bool enabled = true,
      TextInputType kbType = TextInputType.text,
      String hintText = 'Enter value here',
      TextEditingController? contr}) {
    return TextField(
        enabled: enabled,
        cursorColor: FlutterFlowTheme.secondaryColor,
        style: FlutterFlowTheme.bodyText1,
        textAlign: TextAlign.start,
        keyboardType: kbType,
        controller: contr,
        decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ))));
  }
}