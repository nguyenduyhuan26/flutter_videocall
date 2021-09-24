import 'package:flutter/material.dart';
import 'package:flutter_appvideo/providers/video_call.dart';
import 'package:flutter_appvideo/views/video_call_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => VideoCall()),
          ],
          child: VideoCallPage(),
        ));
  }
}
