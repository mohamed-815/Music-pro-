import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_application_1stproject/db/dbfetching.dart';

class AssetAudioPlay {
  AssetsAudioPlayer audioplayer = AssetsAudioPlayer.withId("0");
  List<Audio> audioconvertedsongs;
  int index;
  AssetAudioPlay({required this.audioconvertedsongs, required this.index});
  Future<void> songPlayNow(List<Audio> audioconvertedsongs, int index) async {
    await audioplayer.open(
        showNotification:
            notificationison5 == false || notificationison5 == null
                ? false
                : true,
        Playlist(audios: audioconvertedsongs, startIndex: index));

    //await widget.audioPlayer
    //    .open(audioconvertedsongs[widget.index!], showNotification: true);
    audioplayer.play();
  }
}
