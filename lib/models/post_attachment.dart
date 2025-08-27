import 'package:flutter_dotenv/flutter_dotenv.dart';

class PostAttachment {
  final String id;
  final String format;
  final String mimeType;
  final String? presignedUrl;

  PostAttachment({
    required this.id,
    required this.format,
    required this.mimeType,
    this.presignedUrl
  });

  factory PostAttachment.fromJson(Map<String, dynamic> json) {
    return PostAttachment(
      id: json['id'] ?? "", 
      format: json['format'] ?? '', 
      mimeType: json['mimeType'] ?? '',
      presignedUrl: json['presignedUrl'] ?? ''
    );
  }

  String getUrl(int postId) {
    return "${dotenv.env['R2_PUBLIC_URL']}/post/$postId/attachments/${id}/data.${format}";
  }
}