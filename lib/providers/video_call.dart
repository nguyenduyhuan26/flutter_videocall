import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:agora_rtc_engine/rtc_engine.dart';

class VideoCall with ChangeNotifier, DiagnosticableTreeMixin {
  int _remoteUid;
  int get remoteUid => _remoteUid;
  RtcEngine _engine;
  var appId = "acad51cdd05a4cc9ada772c4d39020c2";
  var token =
      "006acad51cdd05a4cc9ada772c4d39020c2IADuBx8vP2uJmrdSg6bnKJ5EeZqQZ3ae0HZplBlZaXguZSWSch8AAAAAEAD+S/6ME8ZOYQEAAQATxk5h";
  Future<void> requestCamera() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {},
        userJoined: (int uid, int elapsed) {
          _remoteUid = uid;
          notifyListeners();
        },
        userOffline: (int uid, UserOfflineReason reason) {
          _remoteUid = null;
          notifyListeners();
        },
      ),
    );

    await _engine.joinChannel(token, "huannd123", null, 0);
  }
}
