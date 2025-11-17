/// Trip option model representing a travel option (Flight, Train, Bus, etc.)
enum TravelMode {
  flight,
  train,
  bus,
  hotel;

  String get displayName {
    switch (this) {
      case TravelMode.flight:
        return 'Flight';
      case TravelMode.train:
        return 'Train';
      case TravelMode.bus:
        return 'Bus';
      case TravelMode.hotel:
        return 'Hotel';
    }
  }

  String get icon {
    switch (this) {
      case TravelMode.flight:
        return '✈️';
      case TravelMode.train:
        return '🚆';
      case TravelMode.bus:
        return '🚌';
      case TravelMode.hotel:
        return '🏨';
    }
  }
}

class TripOption {
  final String id;
  final TravelMode mode;
  final String from;
  final String to;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final double price;
  final String providerName;
  final String providerLogo;
  final double rating;
  final int reviewCount;
  final String availability;
  final List<String> amenities;
  final bool isRefundable;
  final String? seatType;
  final String? flightClass;

  TripOption({
    required this.id,
    required this.mode,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.providerName,
    required this.providerLogo,
    this.rating = 4.0,
    this.reviewCount = 0,
    this.availability = 'Available',
    this.amenities = const [],
    this.isRefundable = false,
    this.seatType,
    this.flightClass,
  });

  /// Duration of the trip
  Duration get duration => arrivalTime.difference(departureTime);

  /// Formatted duration string (e.g., "2h 30m")
  String get durationString {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return hours > 0 ? '${hours}h ${minutes}m' : '${minutes}m';
  }

  factory TripOption.fromJson(Map<String, dynamic> json) {
    return TripOption(
      id: json['id'],
      mode: TravelMode.values.firstWhere(
        (e) => e.name == json['mode'],
        orElse: () => TravelMode.flight,
      ),
      from: json['from'],
      to: json['to'],
      departureTime: DateTime.parse(json['departureTime']),
      arrivalTime: DateTime.parse(json['arrivalTime']),
      price: (json['price'] as num).toDouble(),
      providerName: json['providerName'],
      providerLogo: json['providerLogo'],
      rating: (json['rating'] as num?)?.toDouble() ?? 4.0,
      reviewCount: json['reviewCount'] ?? 0,
      availability: json['availability'] ?? 'Available',
      amenities: List<String>.from(json['amenities'] ?? []),
      isRefundable: json['isRefundable'] ?? false,
      seatType: json['seatType'],
      flightClass: json['flightClass'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mode': mode.name,
      'from': from,
      'to': to,
      'departureTime': departureTime.toIso8601String(),
      'arrivalTime': arrivalTime.toIso8601String(),
      'price': price,
      'providerName': providerName,
      'providerLogo': providerLogo,
      'rating': rating,
      'reviewCount': reviewCount,
      'availability': availability,
      'amenities': amenities,
      'isRefundable': isRefundable,
      'seatType': seatType,
      'flightClass': flightClass,
    };
  }
}
