import 'package:flutter/material.dart';
class PlayerScreen extends StatefulWidget {
  String? url;
  PlayerScreen({this.url});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  // final VideoViewerController controller = VideoViewerController();
  var isPlay=true;
  @override
  void dispose() {
    // controller.video!.pause();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /*Center(
            child: VideoViewer(
              controller: controller,
              autoPlay: isPlay,
              source: {
                "SubRip Text": VideoSource(
                  video: VideoPlayerController.network(widget.url!),
                  subtitle: {
                    "English": VideoViewerSubtitle.network(
                      "",
                      type: SubtitleType.webvtt,
                    ),
                  },
                )
              },
            ),
          ),
          Positioned(
            right: 12.0,
            child:GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){
                Navigator.pop(context);
                controller.video!.pause();
              },
              child: Container(
                margin: EdgeInsets.only(right: 20,top: 62),
                child: Image.asset(
                  "assets/images/ic_close.png",
                  height:24,
                  width: 24,
                  fit: BoxFit.fill,
                  color: Colors.white,
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
/* Future<bool> _onBackPressed() async {
    controller.video!.pause();
    Navigator.pop(context);
  }*/
}
