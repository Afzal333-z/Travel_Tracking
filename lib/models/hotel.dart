/// Hotel model representing a hotel option
class PricePoint {
  final DateTime date;
  final double price;

  PricePoint({required this.date, required this.price});

  factory PricePoint.fromJson(Map<String, dynamic> json) {
    return PricePoint(
      date: DateTime.parse(json['date']),
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'price': price,
    };
  }
}

class Hotel {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final List<String> photos;
  final double rating;
  final int reviewCount;
  final double price;
  final double distanceFromCenter; // in km
  final List<String> amenities;
  final bool freeCancellation;
  final bool breakfastIncluded;
  final String roomType;
  final List<PricePoint> priceHistory;
  final String? description;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    this.photos = const [],
    this.rating = 4.0,
    this.reviewCount = 0,
    required this.price,
    this.distanceFromCenter = 0,
    this.amenities = const [],
    this.freeCancellation = false,
    this.breakfastIncluded = false,
    this.roomType = 'Standard Room',
    this.priceHistory = const [],
    this.description,
  });

  /// Formatted distance string
  String get distanceString {
    return '${distanceFromCenter.toStringAsFixed(1)} km from center';
  }

  /// Price trend (up, down, or stable)
  String get priceTrend {
    if (priceHistory.length < 2) return 'stable';
    final recent = priceHistory.last.price;
    final previous = priceHistory[priceHistory.length - 2].price;
    if (recent > previous) return 'up';
    if (recent < previous) return 'down';
    return 'stable';
  }

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      imageUrl: json['imageUrl'],
      photos: List<String>.from(json['photos'] ?? []),
      rating: (json['rating'] as num?)?.toDouble() ?? 4.0,
      reviewCount: json['reviewCount'] ?? 0,
      price: (json['price'] as num).toDouble(),
      distanceFromCenter:
          (json['distanceFromCenter'] as num?)?.toDouble() ?? 0,
      amenities: List<String>.from(json['amenities'] ?? []),
      freeCancellation: json['freeCancellation'] ?? false,
      breakfastIncluded: json['breakfastIncluded'] ?? false,
      roomType: json['roomType'] ?? 'Standard Room',
      priceHistory: (json['priceHistory'] as List?)
              ?.map((e) => PricePoint.fromJson(e))
              .toList() ??
          [],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'imageUrl': imageUrl,
      'photos': photos,
      'rating': rating,
      'reviewCount': reviewCount,
      'price': price,
      'distanceFromCenter': distanceFromCenter,
      'amenities': amenities,
      'freeCancellation': freeCancellation,
      'breakfastIncluded': breakfastIncluded,
      'roomType': roomType,
      'priceHistory': priceHistory.map((e) => e.toJson()).toList(),
      'description': description,
    };
  }
}
