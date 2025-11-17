import '../models/user.dart';
import '../mock_data/mock_data.dart';

/// Mock user service for user operations
class MockUserService {
  /// Get current user
  Future<User> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.currentUser;
  }

  /// Get user by ID
  Future<User?> getUserById(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    try {
      return MockData.users.firstWhere((u) => u.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Update user profile
  Future<User> updateProfile(User user) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return user;
  }

  /// Verify user (mock verification process)
  Future<bool> verifyUser({
    required String idProofPath,
    required String ticketPath,
  }) async {
    // Simulate verification process
    await Future.delayed(const Duration(seconds: 2));
    // Always approve for mock
    return true;
  }

  /// Follow a user
  Future<bool> followUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  /// Unfollow a user
  Future<bool> unfollowUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }
}
