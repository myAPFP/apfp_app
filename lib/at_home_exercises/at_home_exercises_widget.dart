import 'package:apfp/firebase/firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../exercise_video/exercise_video_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class AtHomeExercisesWidget extends StatefulWidget {
  AtHomeExercisesWidget({Key? key}) : super(key: key);

  @override
  _AtHomeExercisesWidgetState createState() => _AtHomeExercisesWidgetState();
}

class _AtHomeExercisesWidgetState extends State<AtHomeExercisesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int _index = 0;
  List<Widget> videoList = [];
  bool _isVideosLoaded = false;

  @override
  void initState() {
    super.initState();
    _getPlaylistIDs().then((ids) {
      ids.forEach((id) {
        _preloadYTVideos(id);
      });
      _isVideosLoaded = true;
    });
  }

  List<Padding> _paddedHeaderText() {
    return [
      Padding(
        key: Key('Exercises.header'),
        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 24, 0),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Text('At-Home Exercises', style: FlutterFlowTheme.title1)
        ]),
      ),
      Padding(
          key: Key('Exercises.description'),
          padding: EdgeInsetsDirectional.fromSTEB(16, 4, 24, 10),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
                child: Text(
                    'The following videos are some exercises that can be done at home.' +
                        ' Please remember to be safe when exercising.',
                    style: FlutterFlowTheme.title3))
          ]))
    ];
  }

  Padding _videoTrainingCard(
      {required int index,
      required String author,
      required String url,
      required String title,
      required Video video}) {
    if (title.length > 30) {
      title = "${title.substring(0, 30)}...";
    }
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 8, 10, 0),
        child: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseVideoWidget(video: video),
                ),
              );
            },
            child: Container(
                height: 100,
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
                          SizedBox(width: 40),
                          Text("$_index", style: FlutterFlowTheme.title3),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                child: Stack(children: [
                                  Align(
                                      key: Key('ExerciseTitle'),
                                      alignment:
                                          AlignmentDirectional(-0.1, -0.5),
                                      child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75),
                                          child: AutoSizeText(
                                            title,
                                            maxLines: 1,
                                            style: FlutterFlowTheme.title3,
                                            minFontSize: 18,
                                            overflow: TextOverflow.ellipsis,
                                          ))),
                                  Align(
                                      alignment:
                                          AlignmentDirectional(2.64, 0.55),
                                      child: Padding(
                                          key: Key('ExerciseDescription'),
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: video.duration!.inMinutes > 1
                                              ? Text(
                                                  'Source: $author\nVideo Length: ${video.duration!.inMinutes} minutes',
                                                  style: FlutterFlowTheme
                                                      .subtitle3)
                                              : Text(
                                                  'Source: $author\nVideo Length: ${video.duration!.inSeconds} seconds',
                                                  style: FlutterFlowTheme
                                                      .subtitle3)))
                                ])),
                          ]),
                      // Column(
                      //   children: [
                      //     Expanded(
                      //         flex: 1,
                      //         child: Align(
                      //             alignment: AlignmentDirectional(0.05, 0),
                      //             child: Icon(Icons.chevron_right,
                      //                 color: Color(0xFF95A1AC), size: 28)))
                      //   ],
                      // )
                    ],
                  ),
                ))));
  }

  Future<List<String>> _getPlaylistIDs() async {
    List<String> ids = [];
    await FireStore.getPlaylistID().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        ids.add(doc["id"]);
      });
    });
    return ids;
  }

  void _preloadYTVideos(String id) async {
    YoutubeExplode yt = YoutubeExplode();
    Playlist playlist = await yt.playlists.get(id);
    await for (Video video in yt.playlists.getVideos(playlist.id)) {
      _index++;
      _addVideoToList(_videoTrainingCard(
          index: _index,
          author: video.author,
          url: video.url,
          title: video.title,
          video: video));
    }
    yt.close();
  }

  void _addVideoToList(Padding videoTrainingCard) {
    setState(() {
      videoList.add(videoTrainingCard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _paddedHeaderText()[0],
                _paddedHeaderText()[1],
                !_isVideosLoaded
                    ? Text("Loading Videos...",
                        style: FlutterFlowTheme.subtitle3)
                    : Text("Video Count: ${videoList.length}",
                        style: FlutterFlowTheme.subtitle3),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: videoList,
            ),
            SizedBox(height: 10)
          ]),
        )));
  }
}
