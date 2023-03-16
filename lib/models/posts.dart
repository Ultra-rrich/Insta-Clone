// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String description;
  final String uid;
  final String username;
  final datePublished;
  final String postId;
  final String postUrl;
  final String profImage;
  final likes;

  const Posts({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "postUrl": postUrl,
        "description": description,
        "postId": postId,
        "datePublished": datePublished,
        "profImage": profImage,
        "likes": likes,
      };

  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Posts(
      username: snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
    );
  }
}
