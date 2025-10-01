class ChatAttachment {
  final String id;
  final String link;

  ChatAttachment({
    required this.id,
    required this.link,
  });

  factory ChatAttachment.fromJson(Map<String, dynamic> json) {
    return ChatAttachment(
      id: json['id'], 
      link: json['link']
    );
  }
}