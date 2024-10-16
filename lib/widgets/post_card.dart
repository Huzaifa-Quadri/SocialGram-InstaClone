import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/models/user.dart' as custom;
import 'package:instagram_clone/providers/userprovider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/screens/comment_screen.dart';
import 'package:instagram_clone/utils/global_variables.dart';

import 'package:instagram_clone/utils/theme_layout.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/like_Animation.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool islikeAnimating = false;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final User curruser = FirebaseAuth.instance.currentUser!;
  bool isbookmarked = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        // Access the user data from the provider (nullable User)
        final custom.User? user = userProvider.getUser;

        // Check if user is null, show loading or error message if needed
        if (user == null) {
          return const Center(
            child: Text('User data is still loading...'), // Fallback UI when user is null
          );
        }

        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: width > webScreenwidthSize ? secondaryColor : mobileBackgroundColor
            ),
          color: mobileBackgroundColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                // .copyWith(right: 5),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      foregroundImage: NetworkImage(
                        widget.snap['profImage'],
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.snap['username'],
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        widget.snap['uid'] == curruser.uid ?
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: ListView(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shrinkWrap: true,
                                      children: [
                                        'Delete',
                                        'Hide',
                                        'Report',
                                      ]
                                          .map((e) => InkWell(
                                                onTap: () async {
                                                  try {
                                                    FireStoreMethods().deletePost(
                                                      widget.snap['postId'],
                                                      widget.snap['postUrl'],
                                                    );
                                                  } catch (e) {
                                                    showSnackBar(context, e.toString());
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 16,
                                                  ),
                                                  child: Text(e),
                                                ),
                                              ))
                                          .toList()),
                              )
                            ) : 
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: ListView(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shrinkWrap: true,
                                    children: [
                                      'Hide',
                                      'Report',
                                    ]
                                        .map((e) => InkWell(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                  vertical: 12,
                                                  horizontal: 16,
                                                ),
                                                child: Text(e),
                                              ),
                                            ))
                                        .toList()),
                                ) 
                            );
                      },
                      icon: const Icon(Icons.more_vert_sharp),
                    ),
                  ],
                ),
              ),
              //* Here shows the post Image
              //! All below stuff until inkwell is to carryout like animation on photo and button
              GestureDetector(
                onDoubleTap: () async {
                  await FireStoreMethods().likePost(
                    widget.snap['postId'],
                    user.uid,
                    widget.snap['likes'],
                  );
                  setState(() {
                    islikeAnimating = true;
                    print(islikeAnimating);
                  });
                },
                child: Stack(     // for showing animation above post Image
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      child: Image.network(
                        widget.snap['postUrl'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    AnimatedOpacity( //? to animate fading of like icon on image after animation has been carried out
                      duration: const Duration(milliseconds: 200),
                      opacity: islikeAnimating ? 1 : 0,
                      child: LikeAnimation(
                        isAnimating: islikeAnimating,
                        duration: const Duration(
                          milliseconds: 400,
                        ),
                        onEnd: () {
                          setState(() {
                            islikeAnimating = false;
                          });
                        },
                        child: const Icon(
                          Icons.favorite,
                          size: 120,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  LikeAnimation(
                    isAnimating: widget.snap['likes'].contains(user.uid),
                    smallLikebutton: true,
                    child: IconButton(
                        onPressed: () => FireStoreMethods().likePost(
                              widget.snap['postId'].toString(),
                              user.uid,
                              widget.snap['likes'],
                            ),
                        icon: widget.snap['likes'].contains(user.uid)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(Icons.favorite_border)),
                  ),
                  Text(
                    '${widget.snap['likes'].length}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const Gap(10),

                  //* Comment Button
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CommentScreen(
                                postId: widget.snap['postId'].toString(),
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Image.asset(
                        'assets/images/chat.png',
                        height: 23,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Gap(10),
                  IconButton(
                    icon: const Icon(FluentIcons.send_24_regular),
                    onPressed: () => showDMSnackbar(context),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isbookmarked ? isbookmarked = false :
                          isbookmarked = true;
                        });
                      },
                      icon: isbookmarked ? const Icon(
                        Icons.bookmark_rounded,
                      ) : const Icon(
                        Icons.bookmark_border_outlined,
                      ),
                    )  
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: RichText(
                  text: TextSpan(
                      style: const TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text: "   ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: widget.snap['description'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CommentScreen(
                                postId: widget.snap['postId'].toString(),
                              )));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  // todo optional : Show number of comments
                  child: const Text("View all comments",
                      style: TextStyle(fontSize: 15, color: secondaryColor)),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
