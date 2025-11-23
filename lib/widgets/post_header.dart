import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  final double fontSize;

  const PostHeader({
    super.key,
    this.fontSize = 13
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                Text(
                  "jiungbin0219",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                ),

                Text(
                  "3 weeks ago",
                  style: TextStyle(color: Colors.grey, fontSize: fontSize),
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
    );
  }
}

