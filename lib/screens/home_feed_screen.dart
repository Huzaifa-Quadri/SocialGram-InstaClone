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
      body: ListView(
        children: const[
          PostCard(),
          PostCard(),
          PostCard(),
        ],
      )
    );
  }
}
