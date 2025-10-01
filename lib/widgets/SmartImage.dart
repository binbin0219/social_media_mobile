import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SmartImage extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final Widget? errorWidget; 

  const SmartImage({
    super.key, 
    required this.url, 
    this.width, 
    this.height,
    this.errorWidget
  });

  @override
  State<StatefulWidget> createState() => SmartImageState();
}

class SmartImageState extends State<SmartImage> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.url,
      width: widget.width,
      height: widget.height,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!, 
          highlightColor: Colors.grey[100]!, 
          child: Container(
            width: widget.width ?? double.infinity,
            height: widget.height ?? double.infinity,
            color: Colors.white,
          ),
        );
      },
      errorBuilder: (context, error, stack) => widget.errorWidget ?? const Icon(Icons.error),
    );
  }
}
