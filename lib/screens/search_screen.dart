import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/utils/theme_layout.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchcontroller = TextEditingController();
  bool _isshowusers = false;

  @override
  void dispose() {
    super.dispose();
    _searchcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return Scaffold(
      appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: TextField(
            controller: _searchcontroller,
            decoration: InputDecoration(
              border: inputBorder,
              hintText: 'Search',
              focusedBorder: inputBorder,
              enabledBorder: inputBorder,
              filled: true,
              contentPadding: const EdgeInsets.all(8),
            ),
            keyboardType: TextInputType.text,
            onSubmitted: (valuestr) {
              setState(() {
                _isshowusers = true;
              });
              print(valuestr);
            },
          )),
      body: _isshowusers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'username',
                    isGreaterThanOrEqualTo: _searchcontroller.text,
                  )
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  const Text("No User Found");
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                uid: snapshot.data!.docs[index]['uid']),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            (snapshot.data! as dynamic).docs[index]['photoUrl'],
                          ),
                        ),
                        title: Text(snapshot.data!.docs[index]['username']),
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('datePublished')
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Uh-oh, Something went Wrong"),
                        Text("Try Restarting the App"),
                      ],
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Center(child: Text('No posts found!')),
                  );
                }

                return Padding(
                  //todo : to adjust further based on search bar horizontal size above
                  padding: const EdgeInsets.symmetric(horizontal: 8)
                      .copyWith(top: 8),

                  child: GridView.custom(
                    gridDelegate: SliverQuiltedGridDelegate(
                      crossAxisCount:
                          3, // Maximum number of items horizontally (3)
                      mainAxisSpacing: 8, // Spacing between items vertically
                      crossAxisSpacing: 8, // Spacing between items horizontally

                      pattern: screenWidth > webScreenwidthSize
                          ? const [
                              // If screen is wide, make all squares
                              QuiltedGridTile(1, 1),
                              QuiltedGridTile(1, 1),
                              QuiltedGridTile(1, 1),
                            ]
                          : const [
                              QuiltedGridTile(2, 1), // A large vertical tile
                              QuiltedGridTile(1, 1), // A smaller square tile
                              QuiltedGridTile(1, 1), // Another smaller square tile
                              QuiltedGridTile(1, 2), // A wide horizontal tile
                            ],
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Image.network(
                          snapshot.data!.docs[index]['postUrl'],
                          fit: BoxFit.cover,
                        );
                      },
                      childCount: snapshot.data!.docs.length,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
