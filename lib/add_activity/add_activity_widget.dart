import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddActivityWidget extends StatefulWidget {
  AddActivityWidget({Key key}) : super(key: key);

  @override
  _AddActivityWidgetState createState() => _AddActivityWidgetState();
}

class _AddActivityWidgetState extends State<AddActivityWidget> {
  String dropDownValue1;
  TextEditingController textController;
  String dropDownValue2;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 20),
              child: InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      duration: Duration(milliseconds: 125),
                      reverseDuration: Duration(milliseconds: 125),
                      child: NavBarPage(initialPage: 'Activity'),
                    ),
                  );
                },
                child: Text(
                  '< Go Back',
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Open Sans',
                    color: FlutterFlowTheme.secondaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 0),
              child: Text(
                'Add New Activity',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: FlutterFlowTheme.primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
              child: Text(
                'Name of Activity',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: FlutterFlowTheme.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              child: TextFormField(
                controller: textController,
                obscureText: false,
                decoration: InputDecoration(
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.primaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.primaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: FlutterFlowTheme.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
              child: Text(
                'Type of Exercise',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: FlutterFlowTheme.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              child: FlutterFlowDropDown(
                initialOption: dropDownValue1 ??= 'Select a type',
                options: ['Type 1', 'Type 2'].toList(),
                onChanged: (val) => setState(() => dropDownValue1 = val),
                width: MediaQuery.of(context).size.width,
                height: 50,
                textStyle: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: Colors.black,
                  fontSize: 16,
                ),
                fillColor: Colors.white,
                elevation: 2,
                borderColor: FlutterFlowTheme.primaryColor,
                borderWidth: 0,
                borderRadius: 10,
                margin: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                hidesUnderline: true,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
              child: Text(
                'Duration',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: FlutterFlowTheme.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              child: FlutterFlowDropDown(
                initialOption: dropDownValue2 ??= 'Select a duration',
                options: ['Type 1', 'Type 2'].toList(),
                onChanged: (val) => setState(() => dropDownValue2 = val),
                width: MediaQuery.of(context).size.width,
                height: 50,
                textStyle: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: Colors.black,
                  fontSize: 16,
                ),
                fillColor: Colors.white,
                elevation: 2,
                borderColor: FlutterFlowTheme.primaryColor,
                borderWidth: 0,
                borderRadius: 10,
                margin: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                hidesUnderline: true,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    setState(() => _loadingButton = true);
                    try {
                      await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRight,
                          duration: Duration(milliseconds: 125),
                          reverseDuration: Duration(milliseconds: 125),
                          child: NavBarPage(initialPage: 'Activity'),
                        ),
                      );
                    } finally {
                      setState(() => _loadingButton = false);
                    }
                  },
                  text: 'Submit',
                  options: FFButtonOptions(
                    width: 120,
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
                  ),
                  loading: _loadingButton,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
