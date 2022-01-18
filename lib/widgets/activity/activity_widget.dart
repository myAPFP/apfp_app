import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focused_menu/modals.dart';
import '../add_activity/add_activity_widget.dart';
import '../activity_card/activity_card.dart';
import 'package:apfp/flutter_flow/flutter_flow_theme.dart';
import 'package:apfp/flutter_flow/flutter_flow_widgets.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:flutter/material.dart';

class ActivityWidget extends StatefulWidget {
  late final Stream<DocumentSnapshot<Map<String, dynamic>>> activityStream;
  ActivityWidget({Key? key, required this.activityStream}) : super(key: key);

  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  List<Padding> cards = [];
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void _collectActivity() {
    widget.activityStream
        .forEach((DocumentSnapshot<Map<String, dynamic>> element) {
      cards.clear();
      for (int i = 0; i < element.data()!.length; i++) {
        List<dynamic> activityElement = List.empty(growable: true);
        element.data()!.forEach((key, value) {
          activityElement.add(value);
        });
        addCard(ActivityCard(
                icon: Icons.emoji_events_rounded,
                duration: activityElement[i][2],
                name: activityElement[i][0],
                totalCal: "200",
                type: activityElement[i][1])
            .paddedActivityCard());
      }
    });
  }

  Row _headerTextRow(String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 15),
          child: Text(
            text,
            style: FlutterFlowTheme.title1,
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
      textStyle: FlutterFlowTheme.title2,
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
      key: Key("Activity.addActivityButtton"),
      onPressed: () async {
        setState(() => _loadingButton = true);
        try {
          Padding result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddActivityWidget()));
          addCard(result);
        } finally {
          setState(() => _loadingButton = false);
        }
      },
      text: '+ Add New Activity',
      options: _ffButtonOptions(),
      loading: _loadingButton,
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
    _collectActivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          key: Key("Activity.singleChildScrollView"),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _headerTextRow('Today\'s Activity'),
              Column(
                  children: cards
                      .map((e) => FocusedMenuHolder(
                          menuWidth: MediaQuery.of(context).size.width * 0.50,
                          blurSize: 5.0,
                          menuItemExtent: 45,
                          menuBoxDecoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          duration: Duration(milliseconds: 100),
                          animateMenuItems: true,
                          blurBackgroundColor: Colors.black54,
                          bottomOffsetHeight: 100,
                          openWithTap: true,
                          menuItems: <FocusedMenuItem>[
                            // FocusedMenuItem(title: Text("Open"),trailingIcon: Icon(Icons.open_in_new) ,onPressed: (){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ScreenTwo()));
                            // }),
                            FocusedMenuItem(
                                title: Text("Share"),
                                trailingIcon: Icon(Icons.share),
                                onPressed: () {}),
                            FocusedMenuItem(
                                title: Text("Favorite"),
                                trailingIcon: Icon(Icons.favorite_border),
                                onPressed: () {}),
                            FocusedMenuItem(
                                title: Text("Delete",
                                    style: TextStyle(color: Colors.redAccent)),
                                trailingIcon:
                                    Icon(Icons.delete, color: Colors.redAccent),
                                onPressed: () {
                                  setState(() {
                                    cards.remove(e);
                                  });
                                })
                          ],
                          onPressed: () {},
                          child: e))
                      .toList()),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              _addActivityButton(),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
