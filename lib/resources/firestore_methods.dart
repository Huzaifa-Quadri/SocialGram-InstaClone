
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/comment.dart';
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
      String postUrl = await StorageMethod().uploadImagetoStorage('posts', postImg, true);
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

  Future<void> likePost(String postId, String uid, List likes) async {
    //* Adding and removing particular uid of Users in Array of likes of each post (particularly) based on actions.
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          //? using update as set will impact all values, hence incresing workload
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

  Future<String> postComment(
    String postId,
    String text,
    String userid,
    String username,
    String profileImg,
  ) async {
    String res = "Comment not posted";

    try {
      String commentId = const Uuid().v1();

      Comment comment = Comment(
        uid: userid,
        profImg: profileImg,
        commentId: commentId,
        username: username,
        commentText: text,
        datePublished: DateTime.now(),
        cmtLikes: [],
      );

      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .set(comment.toJson());
      //? creating a subcollection named 'comment' inside posts collection to store comment and relevant data

      res = "success";
    } catch (e) {
      if (kDebugMode) print(e.toString());
      res = e.toString();
    }

    return res;
  }

  Future<void> likeComment(
      String commentId, 
      String postId, 
      String uid, 
      List clikes
    ) async {
    try {
      if (clikes.contains(uid)) {
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
              'cmtlikes': FieldValue.arrayRemove([uid]),
            });
          
      } else {
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
              'cmtlikes': FieldValue.arrayUnion([uid]),
            });
      }
    } catch (cmterr) {
      if (kDebugMode) print("This is why comment like is not working  : ${cmterr.toString()}");
    }
  }

//* Deleting the post completely
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> deletePost(String postId, String postUrl) async{
    try {
      //? First, deleting the image from Firebase Storage using the postUrl
      await _deleteImageFromStorage(postUrl);

      //? then deleteing the post from FirebaseFirestore
      await _firestore.collection('posts').doc(postId).delete();

    } catch (erdel) {
      if (kDebugMode) print(erdel.toString());
    }
  }

  Future<void> _deleteImageFromStorage(String postUrl) async {
    try {
      // Extract the file path from the postUrl
      Reference storageReference = _storage.refFromURL(postUrl);

      // Delete the file from Firebase Storage
      await storageReference.delete();
      print("Image successfully deleted from Firebase Storage.");
    } catch (err) {
      if (kDebugMode) print("Error while deleting image: ${err.toString()}");
    }
  }

  Future<void> followUser(String userid, String followId) async {
    try {
      DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(userid).get();

      List following = (snap.data() as dynamic)['following'];

      if (following.contains(followId)) {
        //* Unfollow
        await _firestore.collection('users').doc(followId).update({
          'followers' : FieldValue.arrayRemove([userid])
        });

        await _firestore.collection('users').doc(userid).update({
          'following' : FieldValue.arrayRemove([followId])
        });

      }else{
        //* Follow
        await _firestore.collection('users').doc(followId).update({
          'followers' : FieldValue.arrayUnion([userid])
        });

        await _firestore.collection('users').doc(userid).update({
          'following' : FieldValue.arrayUnion([followId])
        });
      }

    } catch (erfollow) {
      if (kDebugMode) print("Error while making follow or unfollow : ${erfollow.toString()}");
    }
  }
}
