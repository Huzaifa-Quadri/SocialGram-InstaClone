import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String uid,
    String username,
    String description,
    Uint8List postImg,
    String profImage,
  ) async {
    String res = "Some error Occured";
    try {
      String postUrl =
          await StorageMethod().uploadImagetoStorage('posts', postImg, true);
      String postId = const Uuid().v1();

      Post post = Post(
        uid: uid,
        username: username,
        postId: postId,
        description: description,
        postUrl: postUrl,
        datePublished: DateTime.now(),
        profImage: profImage,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = "success";

    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {  //* Adding and removing particular uid of Users in Array of likes of each post (particularly) based on actions.
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({ //? using update as set will impact all values, hence incresing workload
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (err) {
      print("This is Why Post like Mechanism is not working : ${err.toString()}");
    }
  }
}
