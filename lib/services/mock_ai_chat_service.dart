import '../models/message.dart';
import '../mock_data/mock_data.dart';

/// Mock AI chat service
class MockAIChatService {
  /// Get quick actions
  Future<List<QuickAction>> getQuickActions() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return MockData.quickActions;
  }

  /// Send message and get AI response
  Future<Message> sendMessage(String userMessage) async {
    // Simulate processing time
    await Future.delayed(const Duration(seconds: 1));

    // Get AI response from mock data
    final aiResponseData = MockData.getAIResponse(userMessage);
    final aiResponse = aiResponseData['response'] ?? 'I can help you with that!';

    // Create AI message
    return Message(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      sender: MessageSender.ai,
      content: aiResponse,
      timestamp: DateTime.now(),
    );
  }

  /// Get conversation history (mock)
  Future<List<Message>> getConversationHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      Message(
        id: 'msg_welcome',
        sender: MessageSender.ai,
        content: 'Hello! I\'m your TravelMate AI assistant. How can I help you plan your next adventure?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ];
  }
}
