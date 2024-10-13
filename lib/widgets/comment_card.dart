import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/models/user.dart' as custommodel;
import 'package:instagram_clone/providers/userprovider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';

import 'package:instagram_clone/widgets/like_Animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key, required this.snap, required this.currentpostId});
  final snap;
  
  final String currentpostId;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {

  @override
  Widget build(BuildContext context) {
    
     //* Handling the User model with proper null safety
    custommodel.User? user = Provider.of<UserProvider>(context).getUser;

    //? Adding null check and placeholder handling
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      // color: Colors.white24,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            // backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2023/08/07/15/18/woman-8175307_1280.jpg'),
            backgroundImage: NetworkImage(widget.snap['profImg']), 
            radius: 20,
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username
                Text(
                  widget.snap['uname'],
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),

                // Comment Text
                Text(
                  widget.snap['commentText'],
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                  maxLines: null, // Allow multi-line text
                  softWrap: true, // Ensures the text wraps to the next line when needed
                ),
                const SizedBox(height: 4), 

                // Formatted Date
                Text(
                  DateFormat('dd/MM/yyyy')
                      .format(widget.snap['datePublished'].toDate(),
                  ),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // const Spacer(),
          Row(
            children: [
              LikeAnimation(
                    isAnimating: widget.snap['cmtlikes'].contains(user.uid),
                    smallLikebutton: true,
                    child: IconButton(
                        onPressed: () async{
                          await FireStoreMethods().likeComment(widget.snap['commentId'], widget.currentpostId, user.uid, widget.snap['cmtlikes']);
                        },
                        icon: widget.snap['cmtlikes'].contains(user.uid)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(Icons.favorite_border)),
                            
                  ),
              Text('${widget.snap['cmtlikes'].length}')
            ],
          )
        ],
      ),
    );
  }
}
