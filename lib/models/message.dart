/// Message sender type
enum MessageSender {
  user,
  ai;

  bool get isUser => this == MessageSender.user;
  bool get isAI => this == MessageSender.ai;
}

/// Message model for AI chat assistant
class Message {
  final String id;
  final MessageSender sender;
  final String content;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  Message({
    required this.id,
    required this.sender,
    required this.content,
    required this.timestamp,
    this.metadata,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      sender: MessageSender.values.firstWhere(
        (e) => e.name == json['sender'],
        orElse: () => MessageSender.user,
      ),
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender.name,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'metadata': metadata,
    };
  }
}

/// Quick action for AI chat
class QuickAction {
  final String id;
  final String label;
  final String icon;
  final String prompt;

  QuickAction({
    required this.id,
    required this.label,
    required this.icon,
    required this.prompt,
  });

  factory QuickAction.fromJson(Map<String, dynamic> json) {
    return QuickAction(
      id: json['id'],
      label: json['label'],
      icon: json['icon'],
      prompt: json['prompt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'icon': icon,
      'prompt': prompt,
    };
  }
}
