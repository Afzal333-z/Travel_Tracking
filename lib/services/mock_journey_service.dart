import '../models/journey.dart';
import '../mock_data/mock_data.dart';

/// Mock journey service for travel stories
class MockJourneyService {
  final List<Journey> _localJourneys = [];

  /// Get all journeys
  Future<List<Journey>> getAllJourneys() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [...MockData.journeys, ..._localJourneys];
  }

  /// Get journey by ID
  Future<Journey?> getJourneyById(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    try {
      return [...MockData.journeys, ..._localJourneys]
          .firstWhere((j) => j.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get journeys by user ID
  Future<List<Journey>> getJourneysByUserId(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [...MockData.journeys, ..._localJourneys]
        .where((j) => j.userId == userId)
        .toList();
  }

  /// Create new journey
  Future<Journey> createJourney(Journey journey) async {
    await Future.delayed(const Duration(seconds: 1));
    _localJourneys.add(journey);
    return journey;
  }

  /// Like a journey
  Future<Journey> likeJourney(String journeyId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final journey = await getJourneyById(journeyId);
    if (journey != null) {
      return journey.copyWith(likesCount: journey.likesCount + 1);
    }
    throw Exception('Journey not found');
  }

  /// Add comment to journey
  Future<Journey> addComment(String journeyId, JourneyComment comment) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final journey = await getJourneyById(journeyId);
    if (journey != null) {
      final updatedComments = [...journey.comments, comment];
      return journey.copyWith(
        comments: updatedComments,
        commentsCount: updatedComments.length,
      );
    }
    throw Exception('Journey not found');
  }
}
