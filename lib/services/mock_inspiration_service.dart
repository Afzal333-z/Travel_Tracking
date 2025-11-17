import '../models/inspiration.dart';
import '../mock_data/mock_data.dart';

/// Mock inspiration service for travel ideas
class MockInspirationService {
  /// Get all inspirations
  Future<List<Inspiration>> getAllInspirations() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return MockData.inspirations;
  }

  /// Get daily deals
  Future<List<DailyDeal>> getDailyDeals() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.dailyDeals;
  }

  /// Get inspirations by mood tag
  Future<List<Inspiration>> getInspirationsByMood(String mood) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return MockData.inspirations
        .where((insp) => insp.moodTags
            .any((tag) => tag.toLowerCase() == mood.toLowerCase()))
        .toList();
  }

  /// Get trending destinations
  Future<List<String>> getTrendingDestinations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      'Goa',
      'Manali',
      'Jaipur',
      'Kerala',
      'Ladakh',
    ];
  }
}
