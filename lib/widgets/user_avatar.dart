import 'package:flutter/material.dart';
import 'package:social_media_mobile/utils/utils.dart';
import 'package:social_media_mobile/widgets/SmartImage.dart';

class UserAvatar extends StatefulWidget {
  final int userId;
  final double? width;
  final double? height;

  const UserAvatar({
    super.key, 
    required this.userId,
    this.width,
    this.height
  });

  @override
  State<StatefulWidget> createState() => UserAvatarState();
}

class UserAvatarState extends State<UserAvatar>{
  @override
  Widget build(BuildContext context) {
    return SmartImage(
      url: getUserAvatarUrl(widget.userId),
      width: widget.width,
      height: widget.height,
      errorWidget: Icon(Icons.person, size: widget.height,)
    );
  }
}