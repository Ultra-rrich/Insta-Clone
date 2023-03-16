// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/resources/firestore_methods.dart';
import 'package:insta_clone/theme_assets/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    try {
      String res = await FirestoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        profImage,
        uid,
        profImage,
      );

      if (res == 'success') {
        showSnagBar('posted!', context);
      } else {
        showSnagBar(res, context);
      }
    } catch (e) {
      showSnagBar(e.toString(), context);
    }
  }

  // ignore: unused_element
  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a Post"),
          alignment: Alignment.center,
          children: [
            //camera
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take a photo"),
              onPressed: () async {
                Navigator.of(context).pop;
                // Uint8List file = await pickImage(ImageSource.camera);
                Uint8List? file = await pickImage(ImageSource.camera);

                setState(() {
                  _file = file;
                });
              },
            ),
            //gallery
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Select from Gallery"),
              onPressed: () async {
                Navigator.of(context).pop;
                // Uint8List file = await pickImage(ImageSource.gallery);
                Uint8List? file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            // cancel button
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop;
              },
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final User? user = Provider.of<UserProvider>(context).getUser;
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return
    // user == null
    //      const Center(
    //         child: CircularProgressIndicator(),
    //       )
         _file == null || userProvider.getUser == null
            ? Center(
                child: IconButton(
                  onPressed: () => _selectImage(context),
                  icon: const Icon(Icons.upload),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: mobileBackgroundColor,
                  leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back),
                  ),
                  title: const Text('New post'),
                  centerTitle: false,
                  actions: [
                    //post image check icon button
                    IconButton(
                        onPressed: () => postImage(
                              // userProvider.getUser.uid,
                              // userProvider.getUser.username,
                              // userProvider.getUser.photoUrl,
                              userProvider.getUser!.username,
                              userProvider.getUser!.photoUrl,
                              userProvider.getUser!.uid,
                            ),
                        icon: const Icon(
                          Icons.check,
                          color: Colors.blueAccent,
                        )),
                  ],
                ),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(backgroundImage: NetworkImage(
                                    // userProvider.getUser.photoUrl
                                    userProvider.getUser!.photoUrl)),
                                // "https://images.unsplash.com/photo-1678465739425-778104c26a07?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw4fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=700&q=60")),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .6,
                                  height: 75,
                                  child: TextField(
                                    controller: _descriptionController,
                                    decoration: const InputDecoration(
                                      hintText: 'Write a caption...',
                                      border: InputBorder.none,
                                    ),
                                    maxLines: 8,
                                    scrollPhysics:
                                        const AlwaysScrollableScrollPhysics(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: AspectRatio(
                              aspectRatio: 487 / 451,
                              child: Container(
                                // margin: const EdgeInsets.symmetric(horizontal: 20),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://plus.unsplash.com/premium_photo-1663013194040-6bffa631b78b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=400&q=60"),
                                      fit: BoxFit.fill,
                                      alignment: FractionalOffset.topCenter),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey),
                  ],
                ),
              );
  }
}
