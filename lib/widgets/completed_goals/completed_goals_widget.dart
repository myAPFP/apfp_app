// Copyright 2022 The myAPFP Authors. All rights reserved.

import 'package:apfp/util/toasted/toasted.dart';

import '/firebase/firestore.dart';

import '/flutter_flow/flutter_flow_theme.dart';

import '../confimation_dialog/confirmation_dialog.dart';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompletedGoalsWidget extends StatefulWidget {
  CompletedGoalsWidget({
    Key? key,
  }) : super(key: key);

  /// Takes user to Completed Goals screen.
  ///
  /// By default, completed daily goals are displayed.
  static void launch(BuildContext context, {String mode = "Daily"}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompletedGoalsWidget(),
      ),
    );
  }

  @override
  _CompletedGoalsWidgetState createState() => _CompletedGoalsWidgetState();
}

class _CompletedGoalsWidgetState extends State<CompletedGoalsWidget> {
  /// Serves as key for the [Scaffold] found in [build].
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// The user's daily goal-log collection stream.
  Stream<QuerySnapshot> dailyGoalsLogStream =
      FireStore.getGoalLogCollection(goalType: "daily")
          .orderBy("Date", descending: true)
          .snapshots();

  /// Dictates what type of completed goals are being displayed.
  String _mode = "Daily";

  /// A list of daily [_goalCard] widgets.
  List<Widget> _dailyGoals = [];

  @override
  void initState() {
    super.initState();
    _getPreviousDailyGoals();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Header text. Indicates current type of goal the user is displaying.
  Padding _paddedHeaderText() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 15),
      child: Column(
        children: [
          Row(mainAxisSize: MainAxisSize.max, children: [
            AutoSizeText(
              'Completed $_mode Goals',
              style: FlutterFlowTheme.title1,
              overflow: TextOverflow.fade,
            )
          ]),
        ],
      ),
    );
  }

  /// This is displayed if a user has not completed any goals.
  Column _noGoalsCompletedText() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("No Completed Goals!", style: TextStyle(fontSize: 30))],
    );
  }

  /// When pressed, the user is taken back to Settings.
  Padding _goBackButton() {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 20),
        child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Text('< Go Back', style: FlutterFlowTheme.subtitle2)));
  }

  /// Creates a [Card] with [Padding] applied that displays
  /// information relevant to a goal.
  Padding _goalCard(
      {required Color color,
      required String goalName,
      required String goalInfo,
      required String dateOfCompletion,
      required String goalType}) {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 1,
                color: FlutterFlowTheme.primaryColor,
              ),
            ),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                      Icon(Icons.emoji_events_rounded, color: color, size: 35)
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _titleRow(goalName),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        _goalAttributeRow("Type: ", goalType),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        _goalAttributeRow("Info: ", goalInfo),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        _goalAttributeRow("Completed: ", dateOfCompletion),
                      ]),
                ],
              ),
            )));
  }

  /// Used to created a [_goalCard] title.
  Row _titleRow(String goalName) {
    return Row(children: [
      Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75),
          child: AutoSizeText(
            goalName,
            maxLines: 1,
            style: FlutterFlowTheme.title3,
            overflow: TextOverflow.ellipsis,
            minFontSize: 25,
          ))
    ]);
  }

  /// Used to created a [_goalCard] attribute.
  Row _goalAttributeRow(String label, String value) {
    return Row(children: [
      Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75),
          child: AutoSizeText.rich(
            TextSpan(text: label, style: FlutterFlowTheme.title3Red, children: [
              TextSpan(text: value, style: FlutterFlowTheme.bodyText1)
            ]),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            minFontSize: 17,
          ))
    ]);
  }

  /// Adds a [_goalCard] to the [_dailyGoals] list.
  void _addDailyGoal(Padding goalCard) {
    setState(() {
      _dailyGoals.add(goalCard);
    });
  }

  /// Pre-loads previously completed daily goals stored in Firestore.
  void _getPreviousDailyGoals() {
    dailyGoalsLogStream.forEach(((snapshot) {
      _dailyGoals.clear();
      snapshot.docs.forEach((document) {
        var dayNum = document.get("Date").toString().split('/')[1];
        _addDailyGoal(_goalCard(
            color: FlutterFlowTheme.dayToColor(dayNum),
            goalType: document.get("Type").toString(),
            goalName: document.get("Completed Goal").toString(),
            goalInfo: document.get("Info").toString(),
            dateOfCompletion: document.get("Date").toString()));
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.delete),
            onPressed: () {
              ConfirmationDialog.showConfirmationDialog(
                  context: context,
                  title: Text("Delete All Completed Goals"),
                  content: Text(
                      "This will reset your goal log. This can't be undone.",
                      style: TextStyle(fontSize: 20)),
                  onSubmitTap: () {
                    if (_dailyGoals.isNotEmpty) {
                      FireStore.deleteAllCompletedGoals();
                      setState(() {
                        _dailyGoals.clear();
                      });
                    } else {
                      Toasted.showToast("No goals to delete.");
                    }
                    Navigator.pop(context);
                  },
                  onCancelTap: () {
                    Navigator.pop(context);
                  },
                  cancelText: "Back",
                  submitText: "Reset Log");
            },
            foregroundColor: Colors.white,
            backgroundColor: FlutterFlowTheme.secondaryColor),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _goBackButton(),
                  ],
                ),
                _paddedHeaderText(),
              ],
            ),
            SizedBox(height: 15),
            Column(
                mainAxisSize: MainAxisSize.max,
                children: _dailyGoals.isEmpty
                    ? [_noGoalsCompletedText()]
                    : _dailyGoals),
            SizedBox(height: 10)
          ]),
        )));
  }
}
