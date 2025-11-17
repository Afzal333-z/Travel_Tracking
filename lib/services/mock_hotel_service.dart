import '../models/hotel.dart';
import '../mock_data/mock_data.dart';

/// Mock hotel service
class MockHotelService {
  /// Get hotel suggestions for a destination
  Future<List<Hotel>> getHotelSuggestions({
    required String destination,
    DateTime? checkIn,
    DateTime? checkOut,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Filter hotels by destination
    return MockData.hotels
        .where((hotel) =>
            hotel.location.toLowerCase().contains(destination.toLowerCase()))
        .toList();
  }

  /// Get all hotels
  Future<List<Hotel>> getAllHotels() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return MockData.hotels;
  }

  /// Get hotel by ID
  Future<Hotel?> getHotelById(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    try {
      return MockData.hotels.firstWhere((h) => h.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Sort hotels
  List<Hotel> sortHotels(List<Hotel> hotels, String sortBy) {
    final sorted = List<Hotel>.from(hotels);
    switch (sortBy) {
      case 'price_low':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'rating':
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'distance':
        sorted.sort((a, b) =>
            a.distanceFromCenter.compareTo(b.distanceFromCenter));
        break;
    }
    return sorted;
  }

  /// Filter hotels
  List<Hotel> filterHotels(
    List<Hotel> hotels, {
    double? maxPrice,
    double? minRating,
    bool? freeCancellationOnly,
  }) {
    return hotels.where((hotel) {
      if (maxPrice != null && hotel.price > maxPrice) return false;
      if (minRating != null && hotel.rating < minRating) return false;
      if (freeCancellationOnly == true && !hotel.freeCancellation) {
        return false;
      }
      return true;
    }).toList();
  }
}
