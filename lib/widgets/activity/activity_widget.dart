import 'package:apfp/firebase/firestore.dart';
import 'package:apfp/util/validator/validator.dart';
import 'package:apfp/widgets/confimation_dialog/confirmation_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../add_activity/add_activity_widget.dart';
import '../activity_card/activity_card.dart';
import 'package:apfp/flutter_flow/flutter_flow_theme.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../confimation_dialog/confirmation_dialog.dart';

class ActivityWidget extends StatefulWidget {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> activityStream;
  ActivityWidget({Key? key, required this.activityStream}) : super(key: key);

  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  List<Padding> cards = [];
  XFile? imagepick = null;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Map<String, dynamic> currentSnapshotBackup;

  @override
  void initState() {
    super.initState();
    widget.activityStream.first.then((firstElement) {
      currentSnapshotBackup = firstElement.data()!;
    });
    _collectActivity();
  }

  void _collectActivity() {
    widget.activityStream.forEach((element) {
      Map sortedMap = new Map();
      if (element.data() == null) {
        currentSnapshotBackup = new Map();
      } else {
        currentSnapshotBackup = element.data()!;
        currentSnapshotBackup.forEach((key, value) {
          if (DateTime.parse(key).day != DateTime.now().day) {
            Map<String, dynamic> buffer = element.data()!;
            buffer.remove(key);
            FireStore.updateWorkoutData(buffer);
          }
        });
      }
      setState(() {
        cards.clear();
      });
      sortedMap = Map.fromEntries(currentSnapshotBackup.entries.toList()
        ..sort((e1, e2) => e2.key.compareTo(e1.key)));
      sortedMap.forEach((key, value) {
        addCard(ActivityCard(
                icon: Icons.emoji_events_rounded,
                duration: value[2],
                name: value[0],
                type: value[1],
                timestamp: key != null
                    ? DateTime.parse(key).toIso8601String()
                    : DateTime.now().toIso8601String())
            .paddedActivityCard(context));
      });
    });
  }

  void _addActivityToCloud(ActivityCard activityCard) {
    currentSnapshotBackup.putIfAbsent(activityCard.timestamp.toString(),
        () => [activityCard.name, activityCard.type, activityCard.duration]);
    FireStore.updateWorkoutData(currentSnapshotBackup);
  }

  void _removeActivityFromCloud(String id) {
    currentSnapshotBackup
        .removeWhere((key, value) => (key == id.split(' ')[0]));
    FireStore.updateWorkoutData(currentSnapshotBackup);
  }

  Row _headerTextRow(String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 24, 0),
          child: Text(
            text,
            style: FlutterFlowTheme.title1,
          ),
        ),
      ],
    );
  }

  void addCard(Padding card) {
    setState(() {
      cards.add(card);
    });
  }

  share({String? body, String? subject}) async {
    final box = context.findRenderObject() as RenderBox?;
    imagepick == null
        ? await Share.share(body!,
            subject: subject,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size)
        : await Share.shareFiles([imagepick!.path],
            text: body,
            subject: subject,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  void _showShareWithImageDialog(List<String> cardInfo) async {
    ConfirmationDialog.showConfirmationDialog(
        context: context,
        title: Text('Share Activity?'),
        content: Text(
            'The image you just added will be included with your ${cardInfo[0]} activity.' +
                '\n\nIf you chose no, the image will be deleted.',
            style: TextStyle(fontSize: 20)),
        onSubmitTap: () async {
          share(
              subject: "New Activity Completed!",
              body: 'I completed a new activity! \n\n' +
                  'Activity: ${cardInfo[0].replaceAll(RegExp('-'), ' ')}\n' +
                  'Exercise Type: ${cardInfo[1]}\n' +
                  'Duration: ${cardInfo[2]} ${cardInfo[3]}\n' +
                  '\nSent from the APFP App.');
          imagepick = null;
          Navigator.pop(context);
        },
        onCancelTap: () {
          imagepick = null;
          Navigator.pop(context);
        },
        cancelText: 'No',
        submitText: 'Share');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        child: Icon(Icons.add),
        onPressed: () async {
          try {
            var result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddActivityWidget()));
            if (result != null) {
              _addActivityToCloud(result);
            }
          } finally {}
        },
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          key: Key("Activity.singleChildScrollView"),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _headerTextRow('Today\'s Activity'),
              cards.length > 0
                  ? Column(
                      children: cards
                          .map((e) => FocusedMenuHolder(
                              menuWidth:
                                  MediaQuery.of(context).size.width * 0.50,
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
                                FocusedMenuItem(
                                    title: Text("+ Image/Share"),
                                    trailingIcon: Icon(Icons.image),
                                    onPressed: () async {
                                      final cardInfo =
                                          Validator.cardInfoToList(e)!;
                                      imagepick = null;
                                      imagepick = await ImagePicker().pickImage(
                                          source: ImageSource.camera);
                                      if (imagepick == null) {
                                        return;
                                      } else {
                                        _showShareWithImageDialog(cardInfo);
                                      }
                                    }),
                                FocusedMenuItem(
                                    title: Text("Share"),
                                    trailingIcon: Icon(Icons.share),
                                    onPressed: () {
                                      final cardInfo =
                                          Validator.cardInfoToList(e)!;
                                      share(
                                          subject: "New Activity Completed!",
                                          body: 'I completed a new activity!\n\n' +
                                              'Activity: ${cardInfo[0].replaceAll(RegExp('-'), ' ')}\n' +
                                              'Exercise Type: ${cardInfo[1]}\n' +
                                              'Duration: ${cardInfo[2]} ${cardInfo[3]}\n' +
                                              '\nSent from the APFP App.');
                                    }),
                                FocusedMenuItem(
                                    title: Text("Delete",
                                        style:
                                            TextStyle(color: Colors.redAccent)),
                                    trailingIcon: Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    onPressed: () {
                                      final cardInfo =
                                          Validator.cardInfoToList(e)!;
                                      ConfirmationDialog.showConfirmationDialog(
                                          title: Text("Remove Activity?"),
                                          context: context,
                                          content: Text(
                                              "Do you want to remove your ${cardInfo[1]} activity?" +
                                                  "\n\nThis can't be undone.",
                                              style: TextStyle(fontSize: 20)),
                                          cancelText: 'Back',
                                          submitText: "Remove",
                                          onCancelTap: () {
                                            Navigator.pop(context);
                                          },
                                          onSubmitTap: () {
                                            setState(() {
                                              _removeActivityFromCloud(e.key
                                                  .toString()
                                                  .substring(
                                                      e.key
                                                              .toString()
                                                              .indexOf("'") +
                                                          1,
                                                      e.key
                                                          .toString()
                                                          .lastIndexOf("'")));
                                              cards.remove(e);
                                            });
                                            Navigator.pop(context);
                                          });
                                    })
                              ],
                              onPressed: () {},
                              child: e))
                          .toList())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),
                        Text(
                          'No Activities Recorded!',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'Open Sans',
                          ),
                        ),
                      ],
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
