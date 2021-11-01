import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnouncementWidget extends StatefulWidget {
  AnnouncementWidget({Key key}) : super(key: key);

  @override
  _AnnouncementWidgetState createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 100,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.tertiaryColor,
            border: Border.all(
              color: FlutterFlowTheme.primaryColor,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Icon(
                      Icons.error,
                      color: FlutterFlowTheme.secondaryColor,
                      size: 30,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.74,
                            height: 25,
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.tertiaryColor,
                            ),
                            child: AutoSizeText(
                              'Example announcement subject',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Open Sans',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.74,
                          height: 25,
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.tertiaryColor,
                          ),
                          child: AutoSizeText(
                            'Example announcement information',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
