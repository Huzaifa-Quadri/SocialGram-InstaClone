import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/screens/add_post.dart';
import 'package:instagram_clone/screens/home_feed_screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';
import 'package:instagram_clone/utils/theme_layout.dart';
import 'package:instagram_clone/utils/utils.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {

  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void onTappedNav(int page) {
    //Animating Page
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          alignment: const Alignment(1, 1),
          "assets/images/SocialGram.svg", 
          height: 25,
          color: primaryColor,
        ),
        actions: [
          IconButton(
            onPressed: () => onTappedNav(0),
            icon: Icon(Icons.home, color: _page == 0 ? primaryColor : secondaryColor,),
          ),
          IconButton(
            onPressed: () => onTappedNav(1),
            icon: Icon(Icons.search, color: _page == 1 ? primaryColor : secondaryColor,),
          ),
          IconButton(
            onPressed: () => onTappedNav(2),
            icon: Icon(Icons.add_a_photo, color: _page == 2 ? primaryColor : secondaryColor,),
          ),
          IconButton(
            onPressed: () => heartnotification(context, true),
            icon: Icon(Icons.favorite, color: _page == 3 ? primaryColor : secondaryColor,),
          ),
          IconButton(
            onPressed: () => onTappedNav(4),
            icon: Icon(Icons.person, color: _page == 4 ? primaryColor : secondaryColor,),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          const HomeScreen(),
          const SearchScreen(),
          const AddPostScreen(),
          // const Center(child: Text('Reels')),
          ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
        ],
      ),
    );
  }
}
