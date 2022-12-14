import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1stproject/db/allsongstoringclass.dart';
import 'package:flutter_application_1stproject/db/dbfetching.dart';
import 'package:flutter_application_1stproject/detailsong.dart';
import 'package:flutter_application_1stproject/funtion.dart';
import 'package:marquee/marquee.dart';

class MiniPlayer extends StatefulWidget {
  int? index;
  List<AllSongs>? dbsong1;

  MiniPlayer({this.dbsong1, this.index, Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    final double screenhieght = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    //
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => DetailSong(
                    audioPlayer: audioplayer,
                  )))),
      child: Center(
        child: audioplayer.builderCurrent(builder: (context, Playing? playing) {
          final miniplayersongdetail =
              find(audioconvertedsongs, playing!.audio.assetAudioPath);
          return Container(
            height: screenhieght / 9,
            width: screenwidth,
            child: Card(
              color: Colors.white.withOpacity(.01),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF52796F),
                    radius: 30,
                    child: CircleAvatar(
                      child: PlayerBuilder.isPlaying(
                          player: audioplayer,
                          builder: (context, isPlaying) {
                            return GestureDetector(
                                onTap: () => audioplayer.playOrPause(),
                                child: isPlaying
                                    ? const Icon(Icons.pause,
                                        color: Colors.white)
                                    : const Icon(Icons.play_arrow,
                                        color: Colors.white));
                          }),
                      backgroundColor: const Color.fromARGB(255, 27, 40, 37),
                      radius: 22,
                    ),
                  ),
                  title: Container(
                      child: Marquee(
                          text: miniplayersongdetail.metas.title!,
                          style: TextStyle(fontSize: 20, color: Colors.white))),
                  // subtitle: Marquee(text: miniplayersongdetail.metas.artist!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          recent1 = box.get('recent1')!;
                          final isinrecent = recent1
                              .where(((element) =>
                                  element.id.toString() ==
                                  miniplayersongdetail.metas.id.toString()))
                              .toList();
                          if (isinrecent.isEmpty) {
                            final songmodelsong = dbsongs.firstWhere(
                                (element) =>
                                    element.id.toString() ==
                                    miniplayersongdetail.metas.id.toString());

                            recent1.add(songmodelsong);
                            recent1 = recent1.reversed.toList();
                            if (recent1.length >= 5) {
                              recent1.removeLast();
                            }
                            recent1 = recent1.reversed.toList();
                            await box.put('recent1', recent1);
                            // recent = box.get('recent1')!.toList();
                          }

                          audioplayer.previous();
                        },
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFF52796F),
                          child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Color.fromARGB(255, 27, 40, 37),
                              child:
                                  //  dbsongs[widget.index!] != 0
                                  //     ?

                                  Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                                size: 35,
                              )
                              // : Container()

                              ),
                        ),
                      ),
                      SizedBox(
                        width: screenwidth / 25,
                      ),
                      GestureDetector(
                        onTap: () async {
                          recent1 = box.get('recent1')!;
                          final isinrecent = recent1
                              .where(((element) =>
                                  element.id.toString() ==
                                  miniplayersongdetail.metas.id.toString()))
                              .toList();
                          if (isinrecent.isEmpty) {
                            final songmodelsong = dbsongs.firstWhere(
                                (element) =>
                                    element.id.toString() ==
                                    miniplayersongdetail.metas.id.toString());

                            recent1.add(songmodelsong);
                            recent1 = recent1.reversed.toList();
                            if (recent1.length >= 5) {
                              recent1.removeLast();
                            }
                            recent1 = recent1.reversed.toList();
                            await box.put('recent1', recent1);
                            // recent = box.get('recent1')!.toList();
                          }
                          audioplayer.next();
                        },

                        child: const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFF52796F),
                          child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Color.fromARGB(255, 27, 40, 37),
                              child:
                                  // widget.convertedsongs![widget.index!] !=
                                  //  widget.convertedsongs!.length?
                                  Icon(
                                Icons.skip_next,
                                color: Colors.white,
                                size: 35,
                              )
                              // :
                              //Container()
                              ),
                        ),
                        // CircleAvatar(
                        //   radius: 25,
                        //   backgroundColor: Color(0xFF9d4edd),
                        //   child: CircleAvatar(
                        //     radius: 30,
                        //     backgroundColor: Color.fromARGB(255, 27, 40, 37),
                        //     child: Icon(
                        //       Icons.skip_next,
                        //       color: Colors.white,
                        //       size: 35,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
