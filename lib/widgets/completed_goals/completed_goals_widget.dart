import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../firebase/firestore.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class CompletedGoalsWidget extends StatefulWidget {
  final String? mode;
  CompletedGoalsWidget({Key? key, this.mode}) : super(key: key);

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
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Stream<QuerySnapshot> dailyGoalsLogStream =
      FireStore.getGoalLogCollection(goalType: "daily")
          .orderBy("Date", descending: true)
          .snapshots();

  Stream<QuerySnapshot> weeklyGoalsLogStream =
      FireStore.getGoalLogCollection(goalType: "weekly")
          .orderBy("Date", descending: true)
          .snapshots();

  String _mode = "";
  List<Widget> _dailyGoals = [];
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

  Column _noGoalsText() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("No Completed Goals!", style: TextStyle(fontSize: 30))],
    );
  }

  Padding _goBackButton() {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 20),
        child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Text('< Go Back', style: FlutterFlowTheme.subtitle2)));
  }

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
      _dailyGoals.add(goalCard);
    });
  }

  void _addWeeklyGoal(Padding goalCard) {
    setState(() {
      _weeklyGoals.add(goalCard);
    });
  }

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
                        ? [_noGoalsText()]
                        : _dailyGoals
                    : _weeklyGoals.isEmpty
                        ? [_noGoalsText()]
                        : _weeklyGoals,
              ),
              SizedBox(height: 10)
            ]),
          ))),
    );
  }
}
