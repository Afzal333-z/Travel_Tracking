import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/ai_chat_assistant_screen.dart';
import '../screens/notification_center_screen.dart';

/// App routes configuration
class AppRoutes {
  static const String home = '/';
  static const String aiChat = '/ai-chat';
  static const String notifications = '/notifications';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      aiChat: (context) => const AIChatAssistantScreen(),
      notifications: (context) => const NotificationCenterScreen(),
    };
  }
}
