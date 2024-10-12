import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.snap});
  final snap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      // color: Colors.white24,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            // backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2023/08/07/15/18/woman-8175307_1280.jpg'),
            backgroundImage: NetworkImage(snap['profImg']), 
            radius: 20,
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username
                Text(
                  snap['uname'],
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),

                // Comment Text
                Text(
                  snap['commentText'],
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                  maxLines: null, // Allow multi-line text
                  softWrap: true, // Ensures the text wraps to the next line when needed
                ),
                const SizedBox(height: 4), 

                // Formatted Date
                Text(
                  DateFormat('dd/MM/yyyy')
                      .format(snap['datePublished'].toDate(),
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
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
              const Text('100')
            ],
          )
        ],
      ),
    );
  }
}
