import '../models/trip_option.dart';
import '../mock_data/mock_data.dart';

/// Mock search service for travel options
class MockSearchService {
  /// Search for travel options based on criteria
  Future<List<TripOption>> searchTrips({
    required String from,
    required String to,
    required DateTime date,
    required TravelMode mode,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Filter trips based on criteria
    final results = MockData.getTripOptions(
      from: from.isEmpty ? null : from,
      to: to.isEmpty ? null : to,
      mode: mode,
    );

    return results;
  }

  /// Get all available travel modes
  List<TravelMode> getAvailableModes() {
    return TravelMode.values;
  }

  /// Get popular destinations
  Future<List<String>> getPopularDestinations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      'Mumbai',
      'Delhi',
      'Bangalore',
      'Goa',
      'Jaipur',
      'Pune',
      'Kolkata',
      'Chennai',
      'Hyderabad',
      'Kochi',
    ];
  }

  /// Sort trip options
  List<TripOption> sortTrips(
    List<TripOption> trips,
    String sortBy,
  ) {
    final sorted = List<TripOption>.from(trips);
    switch (sortBy) {
      case 'price_low':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'duration':
        sorted.sort((a, b) => a.duration.compareTo(b.duration));
        break;
      case 'rating':
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default:
        // Keep original order
        break;
    }
    return sorted;
  }

  /// Filter trip options
  List<TripOption> filterTrips(
    List<TripOption> trips, {
    double? maxPrice,
    double? minRating,
    bool? refundableOnly,
  }) {
    return trips.where((trip) {
      if (maxPrice != null && trip.price > maxPrice) return false;
      if (minRating != null && trip.rating < minRating) return false;
      if (refundableOnly == true && !trip.isRefundable) return false;
      return true;
    }).toList();
  }
}
