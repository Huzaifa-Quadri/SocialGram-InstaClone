import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/utils/theme_layout.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    return Scaffold(
        backgroundColor: width > webScreenwidthSize? webBackgroundColor : mobileBackgroundColor,
        appBar: width > webScreenwidthSize ? null : AppBar(
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: SvgPicture.asset(
                alignment: const Alignment(1, 1),
                // "assets/images/ic_instagram.svg",
                // height: 32,
                "assets/images/SocialGram.svg", //* New app wordmark
                height: 25,
                color: primaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (constext) => SimpleDialog(
                          title: const Text('Extra Actions'),
                          children: [
                            SimpleDialogOption(
                              padding: const EdgeInsets.all(25),
                              child: const Text('Add another Account'),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                    );
              },
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
            ),
            const Spacer(),
            IconButton(
                onPressed: () => heartnotification(context, false),
                icon: const Icon(
                  FluentIcons.heart_16_regular,
                  size: 30,
                )),
            // todo No of unseen message count
            Transform.rotate(
              angle: 150,
              child: IconButton(
                onPressed: () => showDMSnackbar(context),
                icon: const Icon(FluentIcons.send_24_regular),
              ),
            )
          ],
        ),
        // body: PostCard(snap: snap));
        body: StreamBuilder(
          //* Stream builder lets us fetch data in real time without refreshing the screen while getting data from database
          stream: FirebaseFirestore.instance
              .collection('posts')
              .snapshots(), //cant use get method as it is future and here we want streambuilder not Future builder
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            //! If there's an error
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong!'),
              );
            }
            //? If no data is returned (empty collection)
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Center(child: Text('No posts found!')),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(
                  horizontal: width > webScreenwidthSize ? width * 0.2 : 0,
                  vertical : width > webScreenwidthSize ? 15 : 0,
                ),
                child: PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              ),
            );
          },
        ));
  }
}
