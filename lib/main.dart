import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart'; 
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';



Future<void> _messageHandler(RemoteMessage message) async {
 
}
late FirebaseMessaging messaging;

  bool _flexibleUpdateAvailable = false;
Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
    initOnseSignal();
  runApp(MyApp());
}
  initOnseSignal() async {
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("messaging");
    messaging.getToken().then((value) {
 
    });
   FirebaseMessaging.onMessage.listen((RemoteMessage event) {
 
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
 
    });
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      initialRoute: AppRoutes.SPLASH_SCREEN,
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
    );
  }
}
