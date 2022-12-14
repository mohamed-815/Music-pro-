import 'package:flutter/material.dart';

import 'package:flutter_application_1stproject/db/dbfetching.dart';
import 'package:flutter_application_1stproject/widjet1/snackbars.dart';

class ShowdialogeEdit extends StatefulWidget {
  String? playlistcurrentname;
  ShowdialogeEdit({required this.playlistcurrentname, super.key});

  @override
  State<ShowdialogeEdit> createState() => _ShowdialogeEditState();
}

class _ShowdialogeEditState extends State<ShowdialogeEdit> {
  final formkey = GlobalKey<FormState>();
  String? changingvaleu;
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 44, 82, 71),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          width: screenwidth / 10,
          height: screenheight / 4,
          child: Column(
            children: [
              Form(
                key: formkey,
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(30)),
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 202, 202, 202)),
                    hintText: widget.playlistcurrentname,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 155, 122, 122),
                        width: 2.0,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    changingvaleu = value.trim();
                  },
                  validator: (value) {
                    List keys = playlistbox.keys.toList();
                    if (value!.trim() == '') {
                      return "Name required";
                    }
                    if (keys
                        .where((element) => element == value.trim())
                        .isNotEmpty) {
                      return "This name is already exists";
                    }
                  },
                ),
              ),
              SizedBox(
                height: screenheight / 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: screenwidth / 4.5,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            submit(controller);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar1().playlistedited);
                          },
                          child: const Text(
                            'Create',
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                    SizedBox(
                      width: screenwidth / 4.5,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void submit(TextEditingController controller) async {
    //playlistName = controller.text;
    //List<AllSongs1> librayry = [];

    List<dynamic> freelist =
        playlistbox.get(widget.playlistcurrentname)!.toList();
    List? excistingName = [];
    if (playlists.isNotEmpty) {
      excistingName =
          playlists.where((element) => element == controller.text).toList();
    }

    if (controller.text != '' &&
        excistingName.isEmpty &&
        formkey.currentState!.validate()) {
      await playlistbox.put(controller.text, freelist);
      await playlistbox.delete(widget.playlistcurrentname);
      Navigator.of(context).pop();

      setState(() {
        playlistkeys = playlistbox.keys.toList();
      });
    }

    // else {
    //   ScaffoldMessenger.of(context).showSnackBar(existingPlaylist);
    // }

    controller.clear();
  }
}
