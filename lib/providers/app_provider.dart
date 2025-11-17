import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/trip_option.dart';
import '../models/journey.dart';
import '../models/hotel.dart';
import '../models/notification_item.dart';
import '../models/daily_insight.dart';
import '../models/message.dart';
import '../models/inspiration.dart';
import '../services/mock_search_service.dart';
import '../services/mock_tracking_service.dart';
import '../services/mock_journey_service.dart';
import '../services/mock_user_service.dart';
import '../services/mock_hotel_service.dart';
import '../services/mock_notification_service.dart';
import '../services/mock_inspiration_service.dart';
import '../services/mock_ai_chat_service.dart';

/// Main app provider that manages all app state
class AppProvider with ChangeNotifier {
  // Services
  final _searchService = MockSearchService();
  final _trackingService = MockTrackingService();
  final _journeyService = MockJourneyService();
  final _userService = MockUserService();
  final _hotelService = MockHotelService();
  final _notificationService = MockNotificationService();
  final _inspirationService = MockInspirationService();
  final _aiChatService = MockAIChatService();

  // State
  User? _currentUser;
  List<TripOption> _searchResults = [];
  List<Journey> _journeys = [];
  List<Hotel> _hotels = [];
  List<NotificationItem> _notifications = [];
  List<DailyInsight> _dailyInsights = [];
  ReadinessScore? _readinessScore;
  List<Inspiration> _inspirations = [];
  List<DailyDeal> _dailyDeals = [];
  List<Message> _chatMessages = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  User? get currentUser => _currentUser;
  List<TripOption> get searchResults => _searchResults;
  List<Journey> get journeys => _journeys;
  List<Hotel> get hotels => _hotels;
  List<NotificationItem> get notifications => _notifications;
  int get unreadNotificationsCount =>
      _notifications.where((n) => !n.isRead).length;
  List<DailyInsight> get dailyInsights => _dailyInsights;
  ReadinessScore? get readinessScore => _readinessScore;
  List<Inspiration> get inspirations => _inspirations;
  List<DailyDeal> get dailyDeals => _dailyDeals;
  List<Message> get chatMessages => _chatMessages;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Initialize app
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = await _userService.getCurrentUser();
      await loadJourneys();
      await loadNotifications();
      await loadDailyInsights();
      await loadInspirations();
      await loadChatHistory();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Search trips
  Future<void> searchTrips({
    required String from,
    required String to,
    required DateTime date,
    required TravelMode mode,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _searchResults = await _searchService.searchTrips(
        from: from,
        to: to,
        date: date,
        mode: mode,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sort search results
  void sortSearchResults(String sortBy) {
    _searchResults = _searchService.sortTrips(_searchResults, sortBy);
    notifyListeners();
  }

  /// Filter search results
  void filterSearchResults({
    double? maxPrice,
    double? minRating,
    bool? refundableOnly,
  }) {
    _searchResults = _searchService.filterTrips(
      _searchResults,
      maxPrice: maxPrice,
      minRating: minRating,
      refundableOnly: refundableOnly,
    );
    notifyListeners();
  }

  /// Load journeys
  Future<void> loadJourneys() async {
    try {
      _journeys = await _journeyService.getAllJourneys();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
  }

  /// Create journey
  Future<bool> createJourney(Journey journey) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _journeyService.createJourney(journey);
      await loadJourneys();
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Like journey
  Future<void> likeJourney(String journeyId) async {
    try {
      await _journeyService.likeJourney(journeyId);
      await loadJourneys();
    } catch (e) {
      _error = e.toString();
    }
  }

  /// Load notifications
  Future<void> loadNotifications() async {
    try {
      _notifications = await _notificationService.getAllNotifications();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
  }

  /// Mark notification as read
  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _notificationService.markAsRead(notificationId);
      await loadNotifications();
    } catch (e) {
      _error = e.toString();
    }
  }

  /// Load daily insights
  Future<void> loadDailyInsights() async {
    try {
      _dailyInsights = await _trackingService.getDailyInsights();
      _readinessScore = await _trackingService.getReadinessScore();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
  }

  /// Refresh insights
  Future<void> refreshInsights() async {
    _isLoading = true;
    notifyListeners();

    try {
      _dailyInsights = await _trackingService.refreshInsights();
      _readinessScore = await _trackingService.getReadinessScore();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load hotels
  Future<void> loadHotels({String? destination}) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (destination != null) {
        _hotels = await _hotelService.getHotelSuggestions(
          destination: destination,
        );
      } else {
        _hotels = await _hotelService.getAllHotels();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load inspirations
  Future<void> loadInspirations() async {
    try {
      _inspirations = await _inspirationService.getAllInspirations();
      _dailyDeals = await _inspirationService.getDailyDeals();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
  }

  /// Load chat history
  Future<void> loadChatHistory() async {
    try {
      _chatMessages = await _aiChatService.getConversationHistory();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
  }

  /// Send chat message
  Future<void> sendChatMessage(String message) async {
    // Add user message
    final userMessage = Message(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      sender: MessageSender.user,
      content: message,
      timestamp: DateTime.now(),
    );
    _chatMessages.add(userMessage);
    notifyListeners();

    try {
      // Get AI response
      final aiMessage = await _aiChatService.sendMessage(message);
      _chatMessages.add(aiMessage);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
  }

  /// Verify user
  Future<bool> verifyUser({
    required String idProofPath,
    required String ticketPath,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _userService.verifyUser(
        idProofPath: idProofPath,
        ticketPath: ticketPath,
      );
      if (result && _currentUser != null) {
        _currentUser = _currentUser!.copyWith(isVerified: true);
      }
      return result;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
