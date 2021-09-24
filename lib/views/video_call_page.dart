import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter_appvideo/providers/video_call.dart';
import 'package:provider/provider.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({Key key}) : super(key: key);

  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  @override
  void initState() {
    super.initState();
    context.read<VideoCall>().requestCamera();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoCall()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Video Call'),
        ),
        body: Stack(
          children: [
            Center(
              child: remoteVideo(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 100,
                height: 100,
                child: Center(
                  child: RtcLocalView.SurfaceView(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Display remote user's video
  Widget remoteVideo() {
    if (context.watch<VideoCall>().remoteUid != null) {
      return RtcRemoteView.SurfaceView(
          uid: context.watch<VideoCall>().remoteUid);
    } else {
      return Text(
        'Đợi thêm người dùng',
        textAlign: TextAlign.center,
      );
    }
  }
}
