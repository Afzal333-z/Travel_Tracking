/// User model representing a traveler in the app
class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final bool isVerified;
  final int journeyCount;
  final int followersCount;
  final int followingCount;
  final DateTime joinedDate;
  final String? bio;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.isVerified = false,
    this.journeyCount = 0,
    this.followersCount = 0,
    this.followingCount = 0,
    required this.joinedDate,
    this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
      isVerified: json['isVerified'] ?? false,
      journeyCount: json['journeyCount'] ?? 0,
      followersCount: json['followersCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      joinedDate: DateTime.parse(json['joinedDate']),
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'isVerified': isVerified,
      'journeyCount': journeyCount,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'joinedDate': joinedDate.toIso8601String(),
      'bio': bio,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    bool? isVerified,
    int? journeyCount,
    int? followersCount,
    int? followingCount,
    DateTime? joinedDate,
    String? bio,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isVerified: isVerified ?? this.isVerified,
      journeyCount: journeyCount ?? this.journeyCount,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      joinedDate: joinedDate ?? this.joinedDate,
      bio: bio ?? this.bio,
    );
  }
}
