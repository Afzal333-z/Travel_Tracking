import '../models/notification_item.dart';
import '../mock_data/mock_data.dart';

/// Mock notification service
class MockNotificationService {
  /// Get all notifications
  Future<List<NotificationItem>> getAllNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.notifications;
  }

  /// Get unread notifications count
  Future<int> getUnreadCount() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return MockData.notifications.where((n) => !n.isRead).length;
  }

  /// Mark notification as read
  Future<NotificationItem> markAsRead(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final notification = MockData.notifications
        .firstWhere((n) => n.id == notificationId);
    return notification.copyWith(isRead: true);
  }

  /// Mark all as read
  Future<bool> markAllAsRead() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  /// Delete notification
  Future<bool> deleteNotification(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }
}
