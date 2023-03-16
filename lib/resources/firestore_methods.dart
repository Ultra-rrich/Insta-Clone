import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/models/posts.dart';
import 'package:insta_clone/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "some error occurred";
    try {
      String photoUrl =
          await StorageMethods().upLoadImageToStorage("posts", file, true);

      String postId = const Uuid().v1();
      Posts posts = Posts(
        description: description,
        uid: uid,
        username: username,
        datePublished: DateTime.now(),
        postId: postId,
        profImage: profImage,
        postUrl: photoUrl,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(
            posts.toJson(),
          );
          res = 'success';
    } catch (err) {
      res = err.toString();
    } return res;
  }
}
