import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_youtube_player.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ExerciseVideoWidget extends StatefulWidget {
  final Video video;
  ExerciseVideoWidget({Key? key, required this.video}) : super(key: key);

  @override
  _ExerciseVideoWidgetState createState() => _ExerciseVideoWidgetState();
}

class _ExerciseVideoWidgetState extends State<ExerciseVideoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Text? _videoTitle, _videoSource;
  Text? _descriptionHeader, _descriptionBody;

  @override
  void initState() {
    super.initState();
    _allowLandscape();
    _loadVideoData();
  }

  void _loadVideoData() {
    setState(() {
      _setVideoTitle(widget.video.title);
      _setVideoSource(widget.video.author);
      _setDiscriptionHeader("Description");
      _setDiscriptionBody(widget.video.description.isEmpty
          ? "No Description Provided."
          : widget.video.description);
    });
  }

  void _allowLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp
    ]);
  }

  void _lockPortait() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  Future<bool> _onWillPop() async {
    _lockPortait();
    Navigator.pop(context, true);
    return false;
  }

  InkWell _goBackToAllVideos() {
    return InkWell(
        onTap: () async {
          _lockPortait();
          Navigator.pop(context);
        },
        child: Text('< Back to All Videos',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Open Sans',
              color: FlutterFlowTheme.secondaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            )));
  }

  void _setVideoTitle(String vTitle) {
    _videoTitle = Text(vTitle,
        style: _bodyText1Style(fontSize: 30, fontWeight: FontWeight.bold));
  }

  void _setVideoSource(String vSource) {
    _videoSource = Text(vSource,
        style: _bodyText1Style(fontSize: 16, fontWeight: FontWeight.normal));
  }

  void _setDiscriptionHeader(String dHeader) {
    _descriptionHeader = Text(dHeader,
        style: _bodyText1Style(fontSize: 20, fontWeight: FontWeight.bold));
  }

  void _setDiscriptionBody(String dBody) {
    _descriptionBody = Text(dBody,
        style: _bodyText1Style(fontSize: 16, fontWeight: FontWeight.normal));
  }

  TextStyle _bodyText1Style({double? fontSize, FontWeight? fontWeight}) {
    return FlutterFlowTheme.bodyText1.override(
      fontFamily: 'Open Sans',
      color: FlutterFlowTheme.primaryColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  FlutterFlowYoutubePlayer _youtubePlayer() {
    return FlutterFlowYoutubePlayer(
      url: widget.video.url,
      autoPlay: false,
      looping: true,
      mute: false,
      showControls: true,
      showFullScreen: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 25, 15, 0),
                    child: _goBackToAllVideos(),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 25, 10, 0),
                    child: _youtubePlayer(),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 25, 15, 0),
                    child: _videoTitle,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                    child: _videoSource,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                    child: _descriptionHeader,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
                    child: _descriptionBody,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
