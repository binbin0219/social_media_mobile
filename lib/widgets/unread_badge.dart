import 'package:flutter/material.dart';

class UnreadBadge extends StatelessWidget {
  final int count;
  const UnreadBadge({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    if(count <= 0) {
      return const SizedBox.shrink();
    }

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle
      ),
      alignment: Alignment.center,
      child: Text(
        count.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 12
        ),
      ),
    );
  }
}