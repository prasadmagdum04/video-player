import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main(){
  runApp(Home());
}
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video',
      home: VideoExample(),
    );
  }
}

class VideoExample extends StatefulWidget {
  VideoExample({Key key}) : super(key: key);
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<VideoExample> {
  VideoPlayerController playerController;
  Future<void> initializeVideoPlayerFuture;


  @override
  void initState(){
    playerController = VideoPlayerController.asset('lib/assets/video.mp4');
    initializeVideoPlayerFuture = playerController.initialize();
    playerController.setLooping(true);
    super.initState();


  }



  @override
  void dispose(){
    playerController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: FutureBuilder(
          future: initializeVideoPlayerFuture,
      builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return AspectRatio(
                  aspectRatio: 16/9,
              child: VideoPlayer(playerController),);

            }
            else{
              return Center(child: CircularProgressIndicator(),);

            }

      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            if(playerController.value.isPlaying){
              playerController.pause();
            }
            else{
              playerController.play();
            }


          });

        },
        child: Icon(
          playerController.value.isPlaying ? Icons.pause : Icons.play_arrow,


        ),
      ),

    );
  }
}


