import 'trip_option.dart';

/// Insight type enum
enum InsightType {
  waitlist,
  price,
  seats,
  weather,
  general;

  String get icon {
    switch (this) {
      case InsightType.waitlist:
        return '🎫';
      case InsightType.price:
        return '💸';
      case InsightType.seats:
        return '💺';
      case InsightType.weather:
        return '🌤️';
      case InsightType.general:
        return 'ℹ️';
    }
  }
}

/// Price history point for tracking
class PriceHistory {
  final DateTime date;
  final double price;

  PriceHistory({required this.date, required this.price});

  factory PriceHistory.fromJson(Map<String, dynamic> json) {
    return PriceHistory(
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

/// Daily insight model for tracking dashboard
class DailyInsight {
  final String id;
  final InsightType type;
  final TravelMode travelMode;
  final String title;
  final String description;
  final String currentValue;
  final String? previousValue;
  final String tripId;
  final String route; // e.g., "Mumbai → Delhi"
  final DateTime timestamp;
  final bool isPositive; // true for improvements, false for worsening
  final List<PriceHistory>? priceHistory;
  final Map<String, dynamic>? metadata;

  DailyInsight({
    required this.id,
    required this.type,
    required this.travelMode,
    required this.title,
    required this.description,
    required this.currentValue,
    this.previousValue,
    required this.tripId,
    required this.route,
    required this.timestamp,
    this.isPositive = true,
    this.priceHistory,
    this.metadata,
  });

  /// Change indicator (e.g., "↓ ₹500" or "↑ WL 5")
  String get changeIndicator {
    if (previousValue == null) return '';
    return isPositive ? '↓' : '↑';
  }

  factory DailyInsight.fromJson(Map<String, dynamic> json) {
    return DailyInsight(
      id: json['id'],
      type: InsightType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => InsightType.general,
      ),
      travelMode: TravelMode.values.firstWhere(
        (e) => e.name == json['travelMode'],
        orElse: () => TravelMode.flight,
      ),
      title: json['title'],
      description: json['description'],
      currentValue: json['currentValue'],
      previousValue: json['previousValue'],
      tripId: json['tripId'],
      route: json['route'],
      timestamp: DateTime.parse(json['timestamp']),
      isPositive: json['isPositive'] ?? true,
      priceHistory: (json['priceHistory'] as List?)
          ?.map((e) => PriceHistory.fromJson(e))
          .toList(),
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'travelMode': travelMode.name,
      'title': title,
      'description': description,
      'currentValue': currentValue,
      'previousValue': previousValue,
      'tripId': tripId,
      'route': route,
      'timestamp': timestamp.toIso8601String(),
      'isPositive': isPositive,
      'priceHistory': priceHistory?.map((e) => e.toJson()).toList(),
      'metadata': metadata,
    };
  }
}

/// Travel readiness score
class ReadinessScore {
  final int score; // 0-100
  final String status; // e.g., "Excellent", "Good", "Fair", "Poor"
  final List<String> factors;
  final DateTime timestamp;

  ReadinessScore({
    required this.score,
    required this.status,
    this.factors = const [],
    required this.timestamp,
  });

  factory ReadinessScore.fromJson(Map<String, dynamic> json) {
    return ReadinessScore(
      score: json['score'],
      status: json['status'],
      factors: List<String>.from(json['factors'] ?? []),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'status': status,
      'factors': factors,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
