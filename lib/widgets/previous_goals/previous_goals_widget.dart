import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../firebase/firestore.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class PreviousGoalsWidget extends StatefulWidget {
  PreviousGoalsWidget({Key? key}) : super(key: key);

  static void launch(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviousGoalsWidget(),
      ),
    );
  }

  @override
  _PreviousGoalsWidgetState createState() => _PreviousGoalsWidgetState();
}

class _PreviousGoalsWidgetState extends State<PreviousGoalsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Stream<QuerySnapshot> dailyGoalsLogStream =
      FireStore.getGoalLogCollection(goalType: "daily")
          .orderBy("Date", descending: true)
          .snapshots();

  Stream<QuerySnapshot> weeklyGoalsLogStream =
      FireStore.getGoalLogCollection(goalType: "weekly")
          .orderBy("Date", descending: true)
          .snapshots();

  int _dailyIndex = 0;
  int _weeklyIndex = 0;
  String mode = "Daily";
  List<Widget> dailyGoals = [];
  List<Widget> weeklyGoals = [];

  @override
  void initState() {
    super.initState();
    _getPreviousDailyGoals();
    _getPreviousWeeklyGoals();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Padding _paddedHeaderText() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 15),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        AutoSizeText(
          'Previously Completed Goals',
          style: FlutterFlowTheme.title1,
          overflow: TextOverflow.fade,
        )
      ]),
    );
  }

  Padding _goalCard(
      {required int index,
      required Color color,
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
                        _goalAttributeRow("Info: ", goalInfo),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        _goalAttributeRow("Completed: ", dateOfCompletion),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        _goalAttributeRow("Type: ", goalType),
                      ]),
                ],
              ),
            )));
  }

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

  void _addDailyGoal(Padding goalCard) {
    setState(() {
      dailyGoals.add(goalCard);
    });
  }

  void _addWeeklyGoal(Padding goalCard) {
    setState(() {
      weeklyGoals.add(goalCard);
    });
  }

  void _getPreviousDailyGoals() {
    dailyGoalsLogStream.forEach(((snapshot) {
      _dailyIndex = 0;
      dailyGoals.clear();
      snapshot.docs.forEach((document) {
        _dailyIndex++;
        var dayNum = document.get("Date").toString().split('/')[1];
        _addDailyGoal(_goalCard(
            index: _dailyIndex,
            color: FlutterFlowTheme.dayToColor(dayNum),
            goalType: document.get("Type").toString(),
            goalName: document.get("Completed Goal").toString(),
            goalInfo: document.get("Info").toString(),
            dateOfCompletion: document.get("Date").toString()));
      });
    }));
  }

  void _getPreviousWeeklyGoals() {
    weeklyGoalsLogStream.forEach(((snapshot) {
      _weeklyIndex = 0;
      weeklyGoals.clear();
      snapshot.docs.forEach((document) {
        _weeklyIndex++;
        var dayNum = document.get("Date").toString().split('/')[1];
        _addWeeklyGoal(_goalCard(
            index: _weeklyIndex,
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          key: scaffoldKey,
          floatingActionButton: FloatingActionButton(
            backgroundColor: FlutterFlowTheme.secondaryColor,
            child: Icon(Icons.code),
            onPressed: () async {
              switch (mode) {
                case "Daily":
                  setState(() => mode = "Weekly");
                  break;
                case "Weekly":
                  setState(() => mode = "Daily");
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
                  _paddedHeaderText(),
                  Text("$mode Goals from previous days will appear here.",
                      style: TextStyle(fontSize: 20))
                ],
              ),
              SizedBox(height: 15),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: mode == "Daily" ? dailyGoals : weeklyGoals,
              ),
              SizedBox(height: 10)
            ]),
          ))),
    );
  }
}
