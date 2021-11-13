import 'package:audio_session/audio_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:just_audio/just_audio.dart';
import 'package:new_version/new_version.dart';
class HomePage extends StatefulWidget {
  ScaffoldState? scaffoldState;
  // Parent? parent;

  // HomePage({this.scaffoldState, this.parent});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with WidgetsBindingObserver {
  late AudioPlayer _player;
  String? streamTitle; 

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer(); 
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
     final newVersion = NewVersion( 
      androidId: 'com.hopecode.radioplenitudesvie',
    );
 advancedStatusCheck(newVersion);
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _player.playbackEventStream.listen((event) {
      setState(() {
        streamTitle = event.icyMetadata!.info!.title;
      });
    }, onError: (Object e, StackTrace stackTrace) {});

    try {
      await _player.setAudioSource(AudioSource.uri(
          Uri.parse("https://www.radioking.com/play/radioplenitudesvie")));
          
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }
  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null && status.localVersion!=status.storeVersion) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
          dismissButtonText:"Plus tard",
        updateButtonText:"Mettre à jour",
        dialogTitle: 'Mise à jour',
        dialogText: 'Une nouvelle mise à jour est disponible. Veillez mettre à jour l\'application pour profiter des nouvelles fonctionnalités',
      );
    }
  } 
  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _player.dispose();
    _player.pause;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            actions: [
              Row(
                children: [
                  IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 20.0,
                color: Colors.white,
                onPressed:()=>{
                  _player.seek(Duration.zero)
                }
              )
                ],
              )
            ],
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Radio PlenitudeS Vie",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(
                    "La Vie de Christ dans toutes Ses PlénitudeS au travers des ondes",
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              )),
          body: Stack(children: [
           
            Container(
            child: SafeArea(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                   SizedBox(child: Image.asset("assets/logo.png"),width: 200,),
                 ControlButtons(_player),
                  streamTitle != null
                      ? Text(streamTitle.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis))
                      : const Text(""),
                 
             
                ],
              )),
            ),
            decoration: BoxDecoration(
               color: Color(0xFF211414),
                image: DecorationImage(
                    image: AssetImage("assets/bg.jpg"))),
          ),
         
          ],));
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: SpinKitFadingCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              );
            } else if (playing != true) {
              return IconButton(
                icon: Icon(Icons.play_circle),
                iconSize: 64.0,
                color: Colors.white,
                onPressed:()=>{
                  player.seek(Duration.zero),
                  player.play()
                }
              );
            } else if (processingState != ProcessingState.completed) {
              return Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.pause_circle),
                    iconSize: 64.0,
                    color: Colors.white,
                    onPressed:()=>{
                        player.pause()
                    }
                  ),
                  SpinKitWave(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              );
            } else {
              return IconButton(
                icon: Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero,
                    index: player.effectiveIndices!.first),
              );
            }
          },
        ),
      ],
    );
  }
}
