import 'package:flutter/material.dart';

class PostCommentButton extends StatefulWidget {
  final int commentCount;
  const PostCommentButton({super.key, this.commentCount = 0});

  @override
  _PostCommentButtonState createState() => _PostCommentButtonState();
}

class _PostCommentButtonState extends State<PostCommentButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6)
      ),
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
              widget.commentCount.toString(),
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
    );
  }
}