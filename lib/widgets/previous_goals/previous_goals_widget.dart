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
  Stream<QuerySnapshot> goalsLogCollectionStream =
      FireStore.getDailyGoalLogCollection().snapshots();

  int _index = 0;
  List<Widget> goals = [];

  @override
  void initState() {
    super.initState();
    _getPreviousGoals();
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
      required String goalName,
      required String goalStat,
      required String dateOfCompletion}) {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
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
                      SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                      Text("$_index", style: FlutterFlowTheme.title3),
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
                        _goalStatRow(goalStat),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        _goalCompletedRow(dateOfCompletion),
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

  Row _goalCompletedRow(String dateOfCompletion) {
    return Row(children: [
      Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: AutoSizeText.rich(
          TextSpan(
              text: 'Completed: ',
              style: FlutterFlowTheme.title3Red,
              children: [
                TextSpan(
                    text: '$dateOfCompletion',
                    style: FlutterFlowTheme.bodyText1)
              ]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          minFontSize: 17,
        ),
      )
    ]);
  }

  Row _goalStatRow(String goalStat) {
    return Row(children: [
      Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75),
          child: AutoSizeText.rich(
            TextSpan(
                text: "Info: ",
                style: FlutterFlowTheme.title3Red,
                children: [
                  TextSpan(text: goalStat, style: FlutterFlowTheme.bodyText1)
                ]),
            overflow: TextOverflow.ellipsis,
            minFontSize: 17,
          ))
    ]);
  }

  void _addGoal(Padding goalCard) {
    setState(() {
      goals.add(goalCard);
    });
  }

  void _getPreviousGoals() {
    goalsLogCollectionStream.forEach(((snapshot) {
      _index = 0;
      goals.clear();
      snapshot.docs.forEach((document) {
        _index++;
        _addGoal(_goalCard(
            index: _index,
            goalName: document.get("Completed Goal").toString(),
            goalStat: document.get("Info").toString(),
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
          backgroundColor: Colors.white,
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [_paddedHeaderText()],
              ),
              goals.length == 0
                  ? Text("Goals from previous days will appear here.",
                      style: TextStyle(fontSize: 20))
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      children: goals,
                    ),
              SizedBox(height: 10)
            ]),
          ))),
    );
  }
}
