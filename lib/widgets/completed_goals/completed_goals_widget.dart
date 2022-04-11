import '/firebase/firestore.dart';

import '/flutter_flow/flutter_flow_theme.dart';

import '../confimation_dialog/confirmation_dialog.dart';

import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CompletedGoalsWidget extends StatefulWidget {

  /// Dictates what type of completed goals are being displayed, daily or weekly.
  final String? mode;

  CompletedGoalsWidget({Key? key, this.mode}) : super(key: key);

  /// Takes user to Completed Goals screen.
  /// 
  /// By default, completed daily goals are displayed.
  static void launch(BuildContext context, {String mode = "Daily"}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompletedGoalsWidget(mode: mode),
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

  /// The user's weekly goal-log collection stream.
  Stream<QuerySnapshot> weeklyGoalsLogStream =
      FireStore.getGoalLogCollection(goalType: "weekly")
          .orderBy("Date", descending: true)
          .snapshots();

  /// Dictates what type of completed goals are being displayed, daily or weekly.
  String _mode = "";

  /// A list of daily [_goalCard] widgets.
  List<Widget> _dailyGoals = [];

  /// A list of weekly [_goalCard] widgets.
  List<Widget> _weeklyGoals = [];

  @override
  void initState() {
    super.initState();
    if (widget.mode == "Daily" || widget.mode == null) {
      _mode = "Daily";
    } else {
      _mode = "Weekly";
    }
    _getPreviousDailyGoals();
    _getPreviousWeeklyGoals();
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

  /// Adds a [_goalCard] to the [_weeklyGoals] list.
  void _addWeeklyGoal(Padding goalCard) {
    setState(() {
      _weeklyGoals.add(goalCard);
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

  /// Pre-loads previously completed weekly goals stored in Firestore.
  void _getPreviousWeeklyGoals() {
    weeklyGoalsLogStream.forEach(((snapshot) {
      _weeklyGoals.clear();
      snapshot.docs.forEach((document) {
        var dayNum = document.get("Date").toString().split('/')[1];
        _addWeeklyGoal(_goalCard(
            color: FlutterFlowTheme.dayToColor(dayNum),
            goalType: document.get("Type").toString(),
            goalName: document.get("Completed Goal").toString(),
            goalInfo: document.get("Info").toString(),
            dateOfCompletion: document.get("Date").toString()));
      });
    }));
  }

  /// Adds a focused menu to a [_goalCard].
  /// 
  /// When a [_goalCard] is pressed, a user will have an option to delete the card.
  FocusedMenuHolder focusedMenu(Widget goalCard) {
    return FocusedMenuHolder(
        menuWidth: MediaQuery.of(context).size.width * 0.50,
        blurSize: 5.0,
        menuItemExtent: 45,
        menuBoxDecoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        duration: Duration(milliseconds: 100),
        animateMenuItems: true,
        blurBackgroundColor: Colors.black54,
        bottomOffsetHeight: 100,
        openWithTap: true,
        menuItems: <FocusedMenuItem>[
          FocusedMenuItem(
              title: Text("Delete", style: TextStyle(color: Colors.redAccent)),
              trailingIcon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                ConfirmationDialog.showConfirmationDialog(
                    title: Text("Remove Goal?"),
                    context: context,
                    content: Text(
                        "Do you want to remove your this goal from your log?" +
                            "\n\nThis can't be undone.",
                        style: TextStyle(fontSize: 20)),
                    cancelText: 'Back',
                    submitText: "Remove",
                    onCancelTap: () {
                      Navigator.pop(context);
                    },
                    onSubmitTap: () {
                      // setState(() {
                      //   _removeActivityFromCloud(e.key
                      //       .toString()
                      //       .substring(
                      //           e.key
                      //                   .toString()
                      //                   .indexOf("'") +
                      //               1,
                      //           e.key
                      //               .toString()
                      //               .lastIndexOf("'")));
                      //   goals.remove(e);
                      // });
                      Navigator.pop(context);
                    });
              })
        ],
        onPressed: () {},
        child: goalCard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        floatingActionButton: FloatingActionButton(
          backgroundColor: FlutterFlowTheme.secondaryColor,
          child: _mode == "Daily"
              ? Text("W", style: TextStyle(fontSize: 25))
              : Text("D", style: TextStyle(fontSize: 25)),
          onPressed: () async {
            switch (_mode) {
              case "Daily":
                setState(() => _mode = "Weekly");
                break;
              case "Weekly":
                setState(() => _mode = "Daily");
                break;
            }
          },
        ),
        backgroundColor: Colors.white,
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
              children: _mode == "Daily"
                  ? _dailyGoals.isEmpty
                      ? [_noGoalsCompletedText()]
                      : _dailyGoals
                          .map((e) => focusedMenu(e))
                          .toList()
                  : _weeklyGoals.isEmpty
                      ? [_noGoalsCompletedText()]
                      : _weeklyGoals
                          .map((e) => focusedMenu(e))
                          .toList(),
            ),
            SizedBox(height: 10)
          ]),
        )));
  }
}
