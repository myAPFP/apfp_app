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
      _setDescriptionHeader("Description");
      _setDescriptionBody(widget.video.description.isEmpty
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

  /* 
    If the user uses the system back button or gesture, _onWillPop()
    is called, which calls _lockPortait() before going back
  */
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
            textAlign: TextAlign.start, style: FlutterFlowTheme.subtitle2));
  }

  void _setVideoTitle(String vTitle) {
    _videoTitle = Text(vTitle, style: FlutterFlowTheme.title1);
  }

  void _setVideoSource(String vSource) {
    _videoSource = Text(vSource, style: FlutterFlowTheme.bodyText1);
  }

  void _setDescriptionHeader(String dHeader) {
    _descriptionHeader = Text(dHeader, style: FlutterFlowTheme.subtitle1);
  }

  void _setDescriptionBody(String dBody) {
    _descriptionBody = Text(dBody, style: FlutterFlowTheme.bodyText1);
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
                    key: Key('Video.videoTitle'),
                    padding: EdgeInsetsDirectional.fromSTEB(15, 25, 15, 0),
                    child: _videoTitle,
                  ),
                  Padding(
                    key: Key('Video.videoSource'),
                    padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                    child: _videoSource,
                  ),
                  Padding(
                    key: Key('Video.videoDescriptionHeader'),
                    padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                    child: _descriptionHeader,
                  ),
                  Padding(
                    key: Key('Video.videoDescriptionBody'),
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
