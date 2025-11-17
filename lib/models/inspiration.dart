/// Inspiration card model for travel inspiration feed
class Inspiration {
  final String id;
  final String destination;
  final String imageUrl;
  final List<String> moodTags;
  final String description;
  final String? bestTimeToVisit;
  final double? estimatedBudget;
  final int durationDays;
  final List<String> highlights;
  final bool isDeal;
  final double? dealDiscount;

  Inspiration({
    required this.id,
    required this.destination,
    required this.imageUrl,
    this.moodTags = const [],
    required this.description,
    this.bestTimeToVisit,
    this.estimatedBudget,
    this.durationDays = 3,
    this.highlights = const [],
    this.isDeal = false,
    this.dealDiscount,
  });

  factory Inspiration.fromJson(Map<String, dynamic> json) {
    return Inspiration(
      id: json['id'],
      destination: json['destination'],
      imageUrl: json['imageUrl'],
      moodTags: List<String>.from(json['moodTags'] ?? []),
      description: json['description'],
      bestTimeToVisit: json['bestTimeToVisit'],
      estimatedBudget: (json['estimatedBudget'] as num?)?.toDouble(),
      durationDays: json['durationDays'] ?? 3,
      highlights: List<String>.from(json['highlights'] ?? []),
      isDeal: json['isDeal'] ?? false,
      dealDiscount: (json['dealDiscount'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'destination': destination,
      'imageUrl': imageUrl,
      'moodTags': moodTags,
      'description': description,
      'bestTimeToVisit': bestTimeToVisit,
      'estimatedBudget': estimatedBudget,
      'durationDays': durationDays,
      'highlights': highlights,
      'isDeal': isDeal,
      'dealDiscount': dealDiscount,
    };
  }
}

/// Daily deal model
class DailyDeal {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double originalPrice;
  final double discountedPrice;
  final double discountPercentage;
  final DateTime validUntil;
  final String destination;
  final String dealType; // e.g., "Flight", "Hotel", "Package"

  DailyDeal({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.validUntil,
    required this.destination,
    required this.dealType,
  });

  /// Time remaining string
  String get timeRemaining {
    final difference = validUntil.difference(DateTime.now());
    if (difference.inDays > 0) {
      return '${difference.inDays} days left';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours left';
    } else {
      return 'Ending soon';
    }
  }

  factory DailyDeal.fromJson(Map<String, dynamic> json) {
    return DailyDeal(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      originalPrice: (json['originalPrice'] as num).toDouble(),
      discountedPrice: (json['discountedPrice'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      validUntil: DateTime.parse(json['validUntil']),
      destination: json['destination'],
      dealType: json['dealType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'discountPercentage': discountPercentage,
      'validUntil': validUntil.toIso8601String(),
      'destination': destination,
      'dealType': dealType,
    };
  }
}
