import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/utils/theme_layout.dart';
import 'package:instagram_clone/widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(
          centerTitle: false,
          actions: [
            SvgPicture.asset(
              alignment: const Alignment(1, 1),
              "assets/images/ic_instagram.svg",
              color: primaryColor,
              height: 32,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  FluentIcons.heart_16_regular,
                  size: 30,
                )),
            // todo No of unseen message count
            Transform.rotate(
              angle: 150,
              child: IconButton(
                onPressed: () {},
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
              itemBuilder: (context, index) => PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
          },
        ));
  }
}
