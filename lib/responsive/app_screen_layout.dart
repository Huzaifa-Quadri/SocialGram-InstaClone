import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post.dart';
import 'package:instagram_clone/screens/home_feed_screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';
import 'package:instagram_clone/utils/theme_layout.dart';

class AppScreenLayout extends StatefulWidget {
  const AppScreenLayout({super.key});

  @override
  State<AppScreenLayout> createState() => _AppScreenLayoutState();
}

class _AppScreenLayoutState extends State<AppScreenLayout> {
  String? username;
  int _page = 2;
  late PageController pagecontroller;

  void onTappedNav(int index) {
    pagecontroller.jumpToPage(index);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pagecontroller = PageController();
  }
  
  @override
  void dispose() {
    super.dispose();
    pagecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        controller: pagecontroller,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children:  [
          const HomeScreen(),
          const SearchScreen(),
          const AddPostScreen(),
          const Center(child: Text('Notify')),
          ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _page,
        onTap: onTappedNav,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FluentIcons.home_12_filled), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(FluentIcons.search_12_regular), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(FluentIcons.add_circle_12_regular), label: "Post"),
          BottomNavigationBarItem(
              icon: Icon(FluentIcons.heart_12_filled), label: "Reel"),
          BottomNavigationBarItem(
              icon: Icon(FluentIcons.person_12_filled), label: "Profile"),
        ],
      ),
    );
  }
}
