class Comment {
  final String uid;
  final String profImg;
  final String commentId;
  final String username;
  final String commentText;
  final DateTime datePublished;
  // final List cmtLike;

  Comment({
    required this.uid,
    required this.profImg,
    required this.commentId,
    required this.username,
    required this.commentText,
    required this.datePublished,
    // required this.cmtLike,
  });

  Map<String, dynamic> toJson() => {
        "profImg": profImg,
        "uname": username,
        "uid": uid,
        "commentId": commentId,
        "commentText": commentText,
        "datePublished": datePublished,
      };
}
