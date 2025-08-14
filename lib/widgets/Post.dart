import 'package:flutter/material.dart';
import 'package:social_media_mobile/widgets/PostAttachmentCarousel.dart';
import 'package:social_media_mobile/widgets/PostContent.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<StatefulWidget> createState() => PostState();
}

class PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // go to profile
                    },
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-vector/smiling-young-man-illustration_1308-174669.jpg',
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "jiungbin0219",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const Text(
                        "3 weeks ago",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),

              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
            ],
          ),

          const SizedBox(height: 12),

          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Example title",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 6),

          Align(alignment: Alignment.topLeft, child: const Postcontent()),

          const SizedBox(height: 12),

          PostAttachmentCarousel(),

          const SizedBox(height: 25),

          Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border, color: Colors.red),
                        const SizedBox(width: 6),
                        Text(
                          "0",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Likes",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 111, 112, 112),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.forum_outlined, color: Colors.blue),
                        const SizedBox(width: 6),
                        Text(
                          "0",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Comments",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 111, 112, 112),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
