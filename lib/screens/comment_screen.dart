import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart' as custommodel;

import 'package:instagram_clone/providers/userprovider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/theme_layout.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/comment_card.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final postId;
  const CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _comment = TextEditingController();

  void comment(String uid, String username, String profImg) async {
    if (_comment.text.isEmpty || _comment.text.length < 2) {
      showSnackBar(context, "Please Write a Comment...");
      return;
    }
    try {
      String res = await FireStoreMethods().postComment(
        widget.postId,
        _comment.text,
        uid,
        username,
        profImg,
      );

      if (mounted) {
        if (res == 'success') {
          showSnackBar(context, "Comment Posted");
        } else {
          showSnackBar(context, "Some Error Occured - ${res.toString()}");
        }
        _comment.clear();
      }
    } catch (erCmt) {
      if (mounted) {
        showSnackBar(context, erCmt.toString());
        print(
            "*****************************${erCmt.toString}************************");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _comment.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    //* Handling the User model with proper null safety
    custommodel.User? user = Provider.of<UserProvider>(context).getUser;

    //? Adding null check and placeholder handling
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.postId)
            .collection('comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.hasError) {
            return const Center(
              child: Text("Something went Wrong!, Try restarting the App"),
            );
          }
          
          if (snapshot.data!.docs.isEmpty) {
            return  const Center(
              child :Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No comments yet'),
                  Text('Be the first one to comment...')
                ],
              )
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => CommentCard(
              snap: snapshot.data!.docs[index], 
              currentpostId: widget.postId,   
            ),
          );
        },
      ),

      //Comment Bar for user to write comment
      bottomNavigationBar: SafeArea(
          child: Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl),
              radius: 18,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8.0),
                child: TextField(
                  controller: _comment,
                  decoration:
                      const InputDecoration(hintText: 'Write a comment'),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                comment(user.uid, user.username, user.photoUrl);
              },
              child: const Text(
                'Post',
                style: TextStyle(color: blueColor, fontSize: 16),
              ),
            )
          ],
        ),
      )),
    );
  }
}
