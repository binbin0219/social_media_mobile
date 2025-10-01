
class CurrentUser {
  final int id;
  final String country;
  final String username;
  final String firstName;
  final String lastName;
  final String description;
  final String occupation;
  final dynamic phoneNumber; // JsonNode equivalent
  final String region;
  final String relationshipStatus;
  final String gender;
  final dynamic friendship;
  final int friendCount;
  final int newNotificationCount;
  final int unreadChatMessageCount;
  final int postCount;
  final int likeCount;
  final DateTime createAt;
  final DateTime updatedAt;

  CurrentUser({
    required this.id,
    required this.country,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.description,
    required this.occupation,
    this.phoneNumber,
    required this.region,
    required this.relationshipStatus,
    required this.gender,
    this.friendship,
    required this.friendCount,
    required this.newNotificationCount,
    required this.unreadChatMessageCount,
    required this.postCount,
    required this.likeCount,
    required this.createAt,
    required this.updatedAt,
  });

  factory CurrentUser.fromJson(Map<String, dynamic> json) {
    return CurrentUser(
      id: json['id'] ?? 0,
      country: json['country'] ?? '',
      username: json['username'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      description: json['description'] ?? '',
      occupation: json['occupation'] ?? '',
      phoneNumber: json['phoneNumber'],
      region: json['region'] ?? '',
      relationshipStatus: json['relationshipStatus'] ?? '',
      gender: json['gender'] ?? '',
      // friendship: json['friendship'] != null
      //     ? Friendship.fromJson(json['friendship'])
      //     : null,
      friendship: null,
      friendCount: json['friendCount'] ?? 0,
      newNotificationCount: json['newNotificationCount'] ?? 0,
      unreadChatMessageCount: json['unreadChatMessageCount'] ?? 0,
      postCount: json['postCount'] ?? 0,
      likeCount: json['likeCount'] ?? 0,
      createAt: DateTime.parse(json['createAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}