import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String uid;
  final String username;
  final String description;
  final String postId;
  final String postUrl;
  final String profImage;
  final DateTime datePublished; //my choce to give it datetime type
  final List likes;

  Post({
      required this.uid,
      required this.username,
      required this.postId,
      required this.description,
      required this.postUrl,
      required this.datePublished,
      required this.profImage,
      required this.likes,
    });

  //? Convert the user object we require here to an object
  //* whenever we call this toJson method on user class it convert everything we reciever from argument to
  //* object file So that we dont have to write same code wherever we use it

  Map<String, dynamic> toJson() => {
        // "uid": uid,
        "uid": uid,
        "username": username,
        "description": description,
        "profImage": profImage,
        "postId": postId,
        "postUrl": postUrl,   //photo url
        "datePublished": datePublished,
        "likes": likes,
      };

  // ignore: non_constant_identifier_names
  static Post passingValue_fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      uid: snapshot['uid'],
      username: snapshot['username'],
      description: snapshot['description'],
      profImage: snapshot['profImage'],
      postId: snapshot['postId'],
      postUrl: snapshot['postUrl'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
    );
  }

  
}
