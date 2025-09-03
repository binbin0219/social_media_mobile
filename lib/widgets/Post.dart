import 'package:flutter/material.dart';
import 'package:social_media_mobile/widgets/PostAttachmentCarousel.dart';
import 'package:social_media_mobile/widgets/PostContent.dart';
import 'package:social_media_mobile/models/post.dart' as post_model;
import 'package:social_media_mobile/widgets/post_like_button.dart';

class Post extends StatefulWidget {
  final post_model.Post post;

  const Post({super.key, required this.post});

  @override
  State<StatefulWidget> createState() => PostState();
}

class PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    print(widget.post.id);
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

              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {
                  showModalBottomSheet(
                    context: context, 
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(Radius.circular(15))
                    ),
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 100,
                              height: 4,
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 212, 212, 212),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),

                            ListTile(
                              leading: Icon(Icons.edit_outlined),
                              title: const Text("Edit"),
                            ),

                            ListTile(
                              leading: Icon(Icons.delete_outline),
                              title: const Text("Delete"),
                            )
                          ],
                        )
                      );
                    }
                  );
                }
              ),
            ],
          ),

          const SizedBox(height: 12),

          Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.post.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 6),

          Align(alignment: Alignment.topLeft, child: Postcontent(content: widget.post.content)),

          const SizedBox(height: 12),

          if(widget.post.attachments.isNotEmpty) 
            PostAttachmentCarousel(attachments: widget.post.attachments, postId: widget.post.id),

          const SizedBox(height: 25),

          Row(
            children: [
              PostLikeButton(
                postId: widget.post.id, 
                likeCount: widget.post.likeCount, 
                liked: widget.post.liked
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
                          widget.post.commentCount.toString(),
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
