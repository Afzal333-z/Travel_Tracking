import 'user.dart';

/// Day-wise itinerary item
class ItineraryDay {
  final int dayNumber;
  final String title;
  final String description;
  final List<String> activities;
  final List<String> photos;

  ItineraryDay({
    required this.dayNumber,
    required this.title,
    required this.description,
    this.activities = const [],
    this.photos = const [],
  });

  factory ItineraryDay.fromJson(Map<String, dynamic> json) {
    return ItineraryDay(
      dayNumber: json['dayNumber'],
      title: json['title'],
      description: json['description'],
      activities: List<String>.from(json['activities'] ?? []),
      photos: List<String>.from(json['photos'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayNumber': dayNumber,
      'title': title,
      'description': description,
      'activities': activities,
      'photos': photos,
    };
  }
}

/// Comment on a journey
class JourneyComment {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String comment;
  final DateTime timestamp;

  JourneyComment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.comment,
    required this.timestamp,
  });

  factory JourneyComment.fromJson(Map<String, dynamic> json) {
    return JourneyComment(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      userAvatar: json['userAvatar'],
      comment: json['comment'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'comment': comment,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

/// User journey/travel story
class Journey {
  final String id;
  final String userId;
  final User user;
  final String title;
  final String destination;
  final String description;
  final List<String> coverPhotos;
  final List<ItineraryDay> itinerary;
  final DateTime startDate;
  final DateTime endDate;
  final int likesCount;
  final int commentsCount;
  final List<JourneyComment> comments;
  final List<String> tags;
  final bool isPublished;
  final DateTime createdAt;
  final String? mapImageUrl;

  Journey({
    required this.id,
    required this.userId,
    required this.user,
    required this.title,
    required this.destination,
    required this.description,
    this.coverPhotos = const [],
    this.itinerary = const [],
    required this.startDate,
    required this.endDate,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.comments = const [],
    this.tags = const [],
    this.isPublished = true,
    required this.createdAt,
    this.mapImageUrl,
  });

  /// Duration of the journey in days
  int get durationDays => endDate.difference(startDate).inDays + 1;

  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      id: json['id'],
      userId: json['userId'],
      user: User.fromJson(json['user']),
      title: json['title'],
      destination: json['destination'],
      description: json['description'],
      coverPhotos: List<String>.from(json['coverPhotos'] ?? []),
      itinerary: (json['itinerary'] as List?)
              ?.map((e) => ItineraryDay.fromJson(e))
              .toList() ??
          [],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      likesCount: json['likesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      comments: (json['comments'] as List?)
              ?.map((e) => JourneyComment.fromJson(e))
              .toList() ??
          [],
      tags: List<String>.from(json['tags'] ?? []),
      isPublished: json['isPublished'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      mapImageUrl: json['mapImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'user': user.toJson(),
      'title': title,
      'destination': destination,
      'description': description,
      'coverPhotos': coverPhotos,
      'itinerary': itinerary.map((e) => e.toJson()).toList(),
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'comments': comments.map((e) => e.toJson()).toList(),
      'tags': tags,
      'isPublished': isPublished,
      'createdAt': createdAt.toIso8601String(),
      'mapImageUrl': mapImageUrl,
    };
  }

  Journey copyWith({
    String? id,
    String? userId,
    User? user,
    String? title,
    String? destination,
    String? description,
    List<String>? coverPhotos,
    List<ItineraryDay>? itinerary,
    DateTime? startDate,
    DateTime? endDate,
    int? likesCount,
    int? commentsCount,
    List<JourneyComment>? comments,
    List<String>? tags,
    bool? isPublished,
    DateTime? createdAt,
    String? mapImageUrl,
  }) {
    return Journey(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      user: user ?? this.user,
      title: title ?? this.title,
      destination: destination ?? this.destination,
      description: description ?? this.description,
      coverPhotos: coverPhotos ?? this.coverPhotos,
      itinerary: itinerary ?? this.itinerary,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      comments: comments ?? this.comments,
      tags: tags ?? this.tags,
      isPublished: isPublished ?? this.isPublished,
      createdAt: createdAt ?? this.createdAt,
      mapImageUrl: mapImageUrl ?? this.mapImageUrl,
    );
  }
}
