import '../models/daily_insight.dart';
import '../mock_data/mock_data.dart';

/// Mock tracking service for daily insights and tracking
class MockTrackingService {
  /// Get daily insights
  Future<List<DailyInsight>> getDailyInsights() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return MockData.dailyInsights;
  }

  /// Get readiness score
  Future<ReadinessScore> getReadinessScore() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.readinessScore;
  }

  /// Refresh insights (simulated update)
  Future<List<DailyInsight>> refreshInsights() async {
    await Future.delayed(const Duration(seconds: 2));
    // In a real app, this would fetch new data
    return MockData.dailyInsights;
  }

  /// Add trip to tracking
  Future<bool> addToTracking(String tripId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Simulate successful addition
    return true;
  }

  /// Remove trip from tracking
  Future<bool> removeFromTracking(String tripId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }
}
