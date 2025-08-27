import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SmartImage extends StatefulWidget {
  final String url;

  const SmartImage({super.key, required this.url});

  @override
  State<StatefulWidget> createState() => SmartImageState();
}

class SmartImageState extends State<SmartImage> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.url,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!, 
          highlightColor: Colors.grey[100]!, 
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
          ),
        );
      },
      errorBuilder: (context, error, stack) => const Icon(Icons.error),
    );
  }
}
