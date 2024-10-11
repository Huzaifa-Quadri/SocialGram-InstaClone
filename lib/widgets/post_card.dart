import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:gap/gap.dart';

import 'package:instagram_clone/utils/theme_layout.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

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
                const CircleAvatar(
                  radius: 20,
                  foregroundImage: NetworkImage(
                      "https://pixabay.com/photos/butterfly-insect-wings-flower-9093549"),
                ),
                const Gap(10),
                const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "username_jo_bhi",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                //todo:  show dialog options - delete, hide, report
                IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_sharp)),
              ],
            ),
          ),
          //! Here shows the post Image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network('https://media.istockphoto.com/id/849220498/photo/blue-tiger-butterfly-on-a-pink-zinnia-flower-with-green-background.jpg?s=2048x2048&w=is&k=20&c=DhUuivmZdPCeouDU5mmE6l8LsgwQtzo_53ucJNmvYp8=', fit: BoxFit.cover,),
          ),
          Row(
            children: [
              IconButton(onPressed: (){}, icon:const Icon(Icons.favorite)), //? Like Button
              const Text('0', style: TextStyle(fontSize: 10),),
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
            child: RichText(text: const TextSpan(
              style: TextStyle(
                fontSize: 15,
                color: primaryColor,
              ),
              children: [
                TextSpan(
                  text: 'User_jobhi',
                  style: TextStyle(fontWeight: FontWeight.bold)
                ),
                TextSpan(
                  text: "   ",
                  style: TextStyle(fontWeight: FontWeight.bold)
                ),
                TextSpan(
                  text: "Today's Weather is great",
                  style: TextStyle(fontWeight: FontWeight.bold)
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
