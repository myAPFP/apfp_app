import '../alert/alert_widget.dart';
import '../components/announcement_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AlertsWidget extends StatefulWidget {
  AlertsWidget({Key? key}) : super(key: key);

  @override
  _AlertsWidgetState createState() => _AlertsWidgetState();
}

class _AlertsWidgetState extends State<AlertsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  InkWell _makeAlert() {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlertWidget(),
          ),
        );
      },
      child: AnnouncementWidget(),
    );
  }

  Padding _paddedAlert(InkWell alert) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [Expanded(child: alert)],
      ),
    );
  }

  AutoSizeText _makeHeader(String text) {
    return AutoSizeText(
      text,
      textAlign: TextAlign.start,
      style: FlutterFlowTheme.bodyText1.override(
        fontFamily: 'Open Sans',
        color: FlutterFlowTheme.primaryColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Padding _paddedHeader(AutoSizeText header) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(25, 50, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: header,
      ),
    );
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _paddedHeader(_makeHeader('Unread Announcements'))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Expanded(child: _makeAlert())],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _paddedHeader(_makeHeader('Previous Announcements')),
                ],
              ),
              _paddedAlert(_makeAlert()),
              _paddedAlert(_makeAlert()),
              _paddedAlert(_makeAlert()),
              _paddedAlert(_makeAlert()),
              _paddedAlert(_makeAlert()),
              _paddedAlert(_makeAlert())
            ],
          ),
        ),
      ),
    );
  }
}
