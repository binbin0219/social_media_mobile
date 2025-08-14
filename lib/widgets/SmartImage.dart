import 'package:flutter/material.dart';

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
        if (loadingProgress == null) return child; // done
        final expected = loadingProgress.expectedTotalBytes;
        final loaded = loadingProgress.cumulativeBytesLoaded;
        return Center(
          child: CircularProgressIndicator(
            value:
                expected != null
                    ? loaded / expected
                    : null, // null = indeterminate
          ),
        );
      },
      errorBuilder: (context, error, stack) => const Icon(Icons.error),
    );
  }
}
