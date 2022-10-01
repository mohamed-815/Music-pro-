import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1stproject/db/allsongstoringclass.dart';
import 'package:flutter_application_1stproject/db/audioplay.dart';
import 'package:flutter_application_1stproject/db/dbfetching.dart';

import 'package:flutter_application_1stproject/miniplayer.dart';

import 'package:on_audio_query/on_audio_query.dart';

class SearchingList extends StatefulWidget {
  const SearchingList({super.key});

  @override
  State<SearchingList> createState() => _SearchingListState();
}

List<AllSongs> listsearch = [];
List<Audio> listsearch1 = [];
String? valeu1;

class _SearchingListState extends State<SearchingList> {
  @override
  Widget build(BuildContext context) {
    final screenhieght = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    final TextEditingController controller1 = TextEditingController();
    return Container(
      height: screenhieght / 2,
      color: const Color.fromARGB(255, 63, 80, 66),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(screenwidth / 45),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.grey),
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: '  search',
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search_outlined,
                    color: Color.fromARGB(255, 63, 62, 62),
                  )),
              controller: controller1,
              onChanged: (value) {
                final valeu1 = value;
                setState(() {
                  listsearch = dbsongs
                      .where((element) => element.title!
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
                listsearch = dbsongs
                    .where((element) => element.title!
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
              },
            ),
          ),
          SizedBox(
            height: screenhieght / 50,
          ),
          listsearch.isNotEmpty
              ? Expanded(
                  flex: 3,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showBottomSheet(
                            backgroundColor: const Color(0xFF52796F),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            context: context,
                            builder: (ctx) => SizedBox(
                                height: screenhieght / 9, child: MiniPlayer()),
                          );
                          for (var element in listsearch) {
                            listsearch1.add(Audio.file(element.uri.toString(),
                                metas: Metas(
                                  title: element.title,
                                  id: element.id.toString(),
                                  artist: element.artist,
                                  album: element.duration.toString(),
                                )));
                          }

                          AssetAudioPlay(
                                  audioconvertedsongs: listsearch1,
                                  index: index)
                              .songPlayNow(listsearch1, index);

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: ((context) => DetailSong(
                          //               audioPlayer: audioplayer,
                          //               index: index,
                          //             ))));
                        },
                        child: ListTile(
                          leading: Container(
                            // padding: EdgeInsets.only(
                            //     top: screenwidth / 50, bottom: screenwidth / 50),
                            width: 50,

                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: QueryArtworkWidget(
                                    nullArtworkWidget: Image.asset(
                                      "assets/best-rap-songs-1583527287.png",
                                    ),
                                    id: int.parse(
                                        listsearch[index].id.toString()),
                                    type: ArtworkType.AUDIO)),
                          ),
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: screenwidth / 3,
                                    margin: const EdgeInsets.only(right: 13),
                                    child: Text(
                                      listsearch[index].title!,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    width: screenwidth / 3,
                                    margin: const EdgeInsets.only(right: 13),
                                    child:
                                        listsearch[index].artist == '<unknown>'
                                            ? const Text(
                                                'unknown artist',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                listsearch[index].artist!,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                  )
                                ],
                              ),
                            ],
                          ),

                          // trailing: GestureDetector(
                          //   onTap: () async {
                          //     setState(() {
                          //       favoritesongs!.removeAt(index);

                          //       favoritebox.put('favorite', favoritesongs!);
                          //     });
                          //   },
                          //   child: Icon(
                          //     Icons.favorite,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          // trailing: GestureDetector(
                          //   onTap: () => Dialogbox2(context),
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       Icon(
                          //         Icons.fiber_manual_record,
                          //         size: 10,
                          //       ),
                          //       Icon(
                          //         Icons.fiber_manual_record,
                          //         size: 10,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ),
                      );
                    },
                    itemCount: listsearch.length,
                  ))
              : Container(
                  height: screenhieght / 3.5,
                  child: const Center(
                      child: Text(
                    'search or not found',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                )
        ],
      ),
    );
  }

  @override
  void dispose() {
    listsearch.clear();
    // TODO: implement dispose
    super.dispose();
  }
}
