import 'package:flutter/material.dart';

class Postcontent extends StatefulWidget {
  final String content;
  const Postcontent({super.key, required this.content});

  @override
  State<StatefulWidget> createState() => PostContentState();
}

class PostContentState extends State<Postcontent> {
  final int max = 100;
  late bool isExeededMax;
  late String firstPart;
  bool isShowingMore = false;

  @override
  void initState() {
    super.initState();
    isExeededMax = widget.content.length > max;

    if (isExeededMax) {
      firstPart = "${widget.content.substring(0, max)}...";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isExeededMax) ...[
          if (!isShowingMore) ...[
            Text(firstPart),
            TextButton(
              onPressed: () => setState(() => isShowingMore = true),
              style: TextButton.styleFrom(
                padding: EdgeInsets.only(top: 8),
                overlayColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                "Show more",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],

          if (isShowingMore) ...[
            Text(widget.content),
            TextButton(
              onPressed: () => setState(() => isShowingMore = false),
              style: TextButton.styleFrom(
                padding: EdgeInsets.only(top: 8),
                overlayColor: Colors.transparent,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                "Show Less",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ] else
          Text(widget.content),
      ],
    );
  }
}
