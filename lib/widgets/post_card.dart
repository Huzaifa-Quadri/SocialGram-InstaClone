import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:gap/gap.dart';

import 'package:instagram_clone/utils/theme_layout.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
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
                      snap['profImage'],  
                    ),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snap['username'],
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                //todo:  make delete option work
                IconButton(onPressed: (){
                  showDialog(context: context, builder: (context) => Dialog(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shrinkWrap: true,
                      children: [
                        'Delete',
                        'Hide',
                        'Report'
                      ].map((e) => InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Text(e),
                        ),
                      )).toList()
                    ),
                  ));
                }, 
                icon: const Icon(Icons.more_vert_sharp),
                ),
              ],
            ),
          ),
          //* Here shows the post Image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(snap['postUrl'], fit: BoxFit.cover,),
          ),
          Row(
            children: [
              IconButton(onPressed: (){}, icon:const Icon(Icons.favorite)), //? Like Button
               Text('${snap['likes'].length}', style: const TextStyle(fontSize: 15),),
              const Gap(10),
              InkWell(    //Comment Button
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Image.asset('assets/images/chat.png' , height: 23, color: Colors.white,),
                ),
              ),
              const Gap(10),
              IconButton(
                  icon: const Icon(FluentIcons.send_24_regular),
                  onPressed: () {},
              ),
              const Spacer(),
              IconButton(onPressed: (){}, icon: const Icon(Icons.bookmark_border_outlined))
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RichText(text: TextSpan(
              style: const TextStyle(
                fontSize: 15,
                color: primaryColor,
              ),
              children: [
                TextSpan(
                  text: snap['username'],
                  style: const TextStyle(fontWeight: FontWeight.bold)
                ),
                const TextSpan(
                  text: "   ",
                  style: TextStyle(fontWeight: FontWeight.bold)
                ),
                TextSpan(
                  text: snap['description'],
                  style: const TextStyle(fontWeight: FontWeight.bold)
                )
              ]
            )),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              // todo optional : Show number of comments
              child: const Text("View all comments",style: TextStyle(fontSize: 15, color: secondaryColor),),
            ),
          )
        ],
      ),
    );
  }
}
