import '../add_activity/add_activity_widget.dart';
import '../activity_card/activity_card.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class ActivityWidget extends StatefulWidget {
  ActivityWidget({Key? key}) : super(key: key);

  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  List<Padding> cards = [];
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Row _headerTextRow(String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 15),
          child: Text(
            text,
            style: FlutterFlowTheme.title1.override(
              fontFamily: 'Open Sans',
              color: FlutterFlowTheme.primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  FFButtonOptions _ffButtonOptions() {
    return FFButtonOptions(
      width: 250,
      height: 50,
      color: FlutterFlowTheme.secondaryColor,
      textStyle: FlutterFlowTheme.subtitle2.override(
        fontFamily: 'Open Sans',
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      elevation: 2,
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 1,
      ),
      borderRadius: 12,
    );
  }

  FFButtonWidget _addActivityButton() {
    return FFButtonWidget(
      onPressed: () async {
        setState(() => _loadingButton = true);
        try {
          Card result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddActivityWidget()));
          addCard(_addPadding(
              height: 120,
              color: Colors.transparent,
              border: Border.all(color: Color(0xFF54585A)),
              borderRadius: BorderRadius.circular(10),
              child: result));
        } finally {
          setState(() => _loadingButton = false);
        }
      },
      text: '+ Add New Activity',
      options: _ffButtonOptions(),
      loading: _loadingButton,
    );
  }

  Padding _addPadding(
      {double? height,
      BorderRadius? borderRadius,
      Color? color,
      Border? border,
      Widget? child}) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
      child: Container(
        child: child,
        height: height,
        decoration: BoxDecoration(
          border: border,
          color: color,
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  void addCard(Padding card) {
    setState(() {
      cards.add(card);
    });
  }

  @override
  void initState() {
    super.initState();

    addCard(_addPadding(
        height: 120,
        color: Colors.transparent,
        border: Border.all(color: Color(0xFF54585A)),
        borderRadius: BorderRadius.circular(10),
        child: ActivityCard(
                icon: Icons.sports_basketball_sharp,
                duration: "30 min",
                totalCal: "300",
                name: "Basketball",
                type: "Cardio")
            .createActivityCard()));

    addCard(_addPadding(
        height: 120,
        color: Colors.transparent,
        border: Border.all(color: Color(0xFF54585A)),
        borderRadius: BorderRadius.circular(10),
        child: ActivityCard(
                icon: Icons.directions_walk_sharp,
                duration: "30 min",
                totalCal: "150",
                name: "Walking",
                type: "Cardio")
            .createActivityCard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _headerTextRow('Today\'s Activity'),
              Column(children: cards),
              _addPadding(
                  height: 80,
                  child: null,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: null),
              _addActivityButton(),
              _addPadding(
                  height: 80,
                  child: null,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: null)
            ],
          ),
        ),
      ),
    );
  }
}
