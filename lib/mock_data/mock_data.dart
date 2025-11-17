import '../models/user.dart';
import '../models/trip_option.dart';
import '../models/journey.dart';
import '../models/hotel.dart';
import '../models/notification_item.dart';
import '../models/daily_insight.dart';
import '../models/message.dart';
import '../models/inspiration.dart';

/// Centralized mock data for the entire app
class MockData {
  // Current user
  static User get currentUser => User(
        id: 'user_1',
        name: 'Rahul Sharma',
        email: 'rahul.sharma@example.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
        isVerified: true,
        journeyCount: 5,
        followersCount: 234,
        followingCount: 156,
        joinedDate: DateTime(2023, 6, 15),
        bio: 'Travel enthusiast | Explorer | Photography lover',
      );

  // Mock users
  static final List<User> users = [
    currentUser,
    User(
      id: 'user_2',
      name: 'Priya Patel',
      email: 'priya.patel@example.com',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      isVerified: true,
      journeyCount: 12,
      followersCount: 567,
      followingCount: 89,
      joinedDate: DateTime(2022, 3, 20),
      bio: 'Wanderlust soul 🌍',
    ),
    User(
      id: 'user_3',
      name: 'Amit Kumar',
      email: 'amit.kumar@example.com',
      avatarUrl: 'https://i.pravatar.cc/150?img=33',
      isVerified: true,
      journeyCount: 8,
      followersCount: 345,
      followingCount: 123,
      joinedDate: DateTime(2023, 1, 10),
      bio: 'Adventure seeker | Mountain lover',
    ),
    User(
      id: 'user_4',
      name: 'Sneha Reddy',
      email: 'sneha.reddy@example.com',
      avatarUrl: 'https://i.pravatar.cc/150?img=9',
      isVerified: false,
      journeyCount: 3,
      followersCount: 89,
      followingCount: 45,
      joinedDate: DateTime(2024, 2, 5),
      bio: 'New to traveling, eager to explore!',
    ),
  ];

  // Mock trip options
  static List<TripOption> getTripOptions({
    String? from,
    String? to,
    TravelMode? mode,
  }) {
    final allOptions = [
      // Flights
      TripOption(
        id: 'flight_1',
        mode: TravelMode.flight,
        from: 'Mumbai',
        to: 'Delhi',
        departureTime: DateTime.now().add(const Duration(days: 5, hours: 6)),
        arrivalTime: DateTime.now().add(const Duration(days: 5, hours: 8, minutes: 15)),
        price: 3999,
        providerName: 'IndiGo',
        providerLogo: 'https://via.placeholder.com/50',
        rating: 4.5,
        reviewCount: 1234,
        availability: 'Available',
        amenities: ['WiFi', 'Meal', 'Entertainment'],
        isRefundable: true,
        flightClass: 'Economy',
      ),
      TripOption(
        id: 'flight_2',
        mode: TravelMode.flight,
        from: 'Mumbai',
        to: 'Delhi',
        departureTime: DateTime.now().add(const Duration(days: 5, hours: 10)),
        arrivalTime: DateTime.now().add(const Duration(days: 5, hours: 12, minutes: 20)),
        price: 4500,
        providerName: 'Air India',
        providerLogo: 'https://via.placeholder.com/50',
        rating: 4.2,
        reviewCount: 890,
        availability: 'Available',
        amenities: ['WiFi', 'Meal', 'Entertainment', 'Extra Legroom'],
        isRefundable: true,
        flightClass: 'Business',
      ),
      TripOption(
        id: 'flight_3',
        mode: TravelMode.flight,
        from: 'Bangalore',
        to: 'Goa',
        departureTime: DateTime.now().add(const Duration(days: 3, hours: 7)),
        arrivalTime: DateTime.now().add(const Duration(days: 3, hours: 8, minutes: 10)),
        price: 2499,
        providerName: 'SpiceJet',
        providerLogo: 'https://via.placeholder.com/50',
        rating: 4.0,
        reviewCount: 567,
        availability: 'Available',
        amenities: ['Meal'],
        isRefundable: false,
        flightClass: 'Economy',
      ),
      // Trains
      TripOption(
        id: 'train_1',
        mode: TravelMode.train,
        from: 'Mumbai',
        to: 'Delhi',
        departureTime: DateTime.now().add(const Duration(days: 5, hours: 16)),
        arrivalTime: DateTime.now().add(const Duration(days: 6, hours: 8)),
        price: 1500,
        providerName: 'Rajdhani Express',
        providerLogo: 'https://via.placeholder.com/50',
        rating: 4.3,
        reviewCount: 2345,
        availability: 'WL 14',
        amenities: ['AC', 'Meals', 'Bedding'],
        isRefundable: true,
        seatType: '2A',
      ),
      TripOption(
        id: 'train_2',
        mode: TravelMode.train,
        from: 'Mumbai',
        to: 'Delhi',
        departureTime: DateTime.now().add(const Duration(days: 5, hours: 20)),
        arrivalTime: DateTime.now().add(const Duration(days: 6, hours: 14)),
        price: 800,
        providerName: 'Duronto Express',
        providerLogo: 'https://via.placeholder.com/50',
        rating: 4.1,
        reviewCount: 1876,
        availability: 'Available',
        amenities: ['AC', 'Meals'],
        isRefundable: true,
        seatType: '3A',
      ),
      // Buses
      TripOption(
        id: 'bus_1',
        mode: TravelMode.bus,
        from: 'Mumbai',
        to: 'Pune',
        departureTime: DateTime.now().add(const Duration(days: 2, hours: 22)),
        arrivalTime: DateTime.now().add(const Duration(days: 3, hours: 4)),
        price: 450,
        providerName: 'RedBus Travels',
        providerLogo: 'https://via.placeholder.com/50',
        rating: 4.4,
        reviewCount: 456,
        availability: '14 seats left',
        amenities: ['AC', 'WiFi', 'Charging'],
        isRefundable: false,
        seatType: 'Sleeper',
      ),
      TripOption(
        id: 'bus_2',
        mode: TravelMode.bus,
        from: 'Delhi',
        to: 'Jaipur',
        departureTime: DateTime.now().add(const Duration(days: 4, hours: 6)),
        arrivalTime: DateTime.now().add(const Duration(days: 4, hours: 11)),
        price: 600,
        providerName: 'VRL Travels',
        providerLogo: 'https://via.placeholder.com/50',
        rating: 4.2,
        reviewCount: 234,
        availability: '8 seats left',
        amenities: ['AC', 'Charging', 'Water'],
        isRefundable: true,
        seatType: 'Semi-Sleeper',
      ),
    ];

    // Filter based on parameters
    return allOptions.where((option) {
      if (from != null && option.from != from) return false;
      if (to != null && option.to != to) return false;
      if (mode != null && option.mode != mode) return false;
      return true;
    }).toList();
  }

  // Mock hotels
  static final List<Hotel> hotels = [
    Hotel(
      id: 'hotel_1',
      name: 'Taj Palace',
      location: 'Mumbai',
      imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400',
      photos: [
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400',
        'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=400',
      ],
      rating: 4.8,
      reviewCount: 1234,
      price: 12000,
      distanceFromCenter: 2.5,
      amenities: ['Pool', 'Spa', 'Gym', 'Restaurant', 'Free WiFi', 'Parking'],
      freeCancellation: true,
      breakfastIncluded: true,
      roomType: 'Deluxe Room',
      priceHistory: [
        PricePoint(date: DateTime.now().subtract(const Duration(days: 7)), price: 13000),
        PricePoint(date: DateTime.now().subtract(const Duration(days: 5)), price: 12500),
        PricePoint(date: DateTime.now().subtract(const Duration(days: 3)), price: 12200),
        PricePoint(date: DateTime.now(), price: 12000),
      ],
      description: 'Luxury 5-star hotel with breathtaking views',
    ),
    Hotel(
      id: 'hotel_2',
      name: 'The Oberoi',
      location: 'Delhi',
      imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=400',
      photos: [
        'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=400',
      ],
      rating: 4.7,
      reviewCount: 987,
      price: 10500,
      distanceFromCenter: 3.2,
      amenities: ['Pool', 'Spa', 'Restaurant', 'Free WiFi', 'Parking'],
      freeCancellation: true,
      breakfastIncluded: true,
      roomType: 'Premium Room',
      priceHistory: [
        PricePoint(date: DateTime.now().subtract(const Duration(days: 6)), price: 11000),
        PricePoint(date: DateTime.now().subtract(const Duration(days: 3)), price: 10800),
        PricePoint(date: DateTime.now(), price: 10500),
      ],
      description: 'Elegant hotel in the heart of Delhi',
    ),
    Hotel(
      id: 'hotel_3',
      name: 'Beach Resort Paradise',
      location: 'Goa',
      imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=400',
      photos: [
        'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=400',
      ],
      rating: 4.6,
      reviewCount: 756,
      price: 8000,
      distanceFromCenter: 5.0,
      amenities: ['Beach Access', 'Pool', 'Restaurant', 'Bar', 'Free WiFi'],
      freeCancellation: true,
      breakfastIncluded: true,
      roomType: 'Ocean View Room',
      priceHistory: [
        PricePoint(date: DateTime.now().subtract(const Duration(days: 5)), price: 9000),
        PricePoint(date: DateTime.now().subtract(const Duration(days: 2)), price: 8500),
        PricePoint(date: DateTime.now(), price: 8000),
      ],
      description: 'Beachfront resort with stunning ocean views',
    ),
    Hotel(
      id: 'hotel_4',
      name: 'Heritage Inn',
      location: 'Jaipur',
      imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=400',
      photos: [
        'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=400',
      ],
      rating: 4.4,
      reviewCount: 543,
      price: 6500,
      distanceFromCenter: 1.8,
      amenities: ['Restaurant', 'Free WiFi', 'Parking', 'Heritage Property'],
      freeCancellation: false,
      breakfastIncluded: true,
      roomType: 'Heritage Room',
      priceHistory: [
        PricePoint(date: DateTime.now().subtract(const Duration(days: 4)), price: 7000),
        PricePoint(date: DateTime.now().subtract(const Duration(days: 1)), price: 6500),
        PricePoint(date: DateTime.now(), price: 6500),
      ],
      description: 'Traditional Rajasthani heritage hotel',
    ),
    Hotel(
      id: 'hotel_5',
      name: 'Mountain View Resort',
      location: 'Manali',
      imageUrl: 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=400',
      photos: [
        'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=400',
      ],
      rating: 4.5,
      reviewCount: 678,
      price: 5500,
      distanceFromCenter: 4.5,
      amenities: ['Mountain View', 'Restaurant', 'Bonfire', 'Free WiFi'],
      freeCancellation: true,
      breakfastIncluded: true,
      roomType: 'Valley View Room',
      priceHistory: [
        PricePoint(date: DateTime.now().subtract(const Duration(days: 3)), price: 6000),
        PricePoint(date: DateTime.now(), price: 5500),
      ],
      description: 'Cozy resort with panoramic mountain views',
    ),
  ];

  // Mock journeys
  static final List<Journey> journeys = [
    Journey(
      id: 'journey_1',
      userId: 'user_2',
      user: users[1],
      title: 'Magical Kerala Backwaters',
      destination: 'Kerala',
      description: 'An unforgettable journey through the serene backwaters of Kerala',
      coverPhotos: [
        'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=400',
        'https://images.unsplash.com/photo-1593693397690-362cb2e3838c?w=400',
      ],
      itinerary: [
        ItineraryDay(
          dayNumber: 1,
          title: 'Arrival in Kochi',
          description: 'Explored Fort Kochi and its colonial architecture',
          activities: [
            'Chinese Fishing Nets',
            'St. Francis Church',
            'Mattancherry Palace',
          ],
          photos: [
            'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=300',
          ],
        ),
        ItineraryDay(
          dayNumber: 2,
          title: 'Houseboat Experience',
          description: 'Cruise through the beautiful backwaters',
          activities: [
            'Houseboat cruise',
            'Village visits',
            'Traditional Kerala lunch',
          ],
          photos: [
            'https://images.unsplash.com/photo-1593693397690-362cb2e3838c?w=300',
          ],
        ),
        ItineraryDay(
          dayNumber: 3,
          title: 'Munnar Tea Gardens',
          description: 'Visited the lush tea plantations',
          activities: [
            'Tea factory tour',
            'Eravikulam National Park',
            'Tea tasting',
          ],
          photos: [],
        ),
      ],
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now().subtract(const Duration(days: 27)),
      likesCount: 456,
      commentsCount: 34,
      comments: [
        JourneyComment(
          id: 'comment_1',
          userId: 'user_1',
          userName: 'Rahul Sharma',
          userAvatar: 'https://i.pravatar.cc/150?img=12',
          comment: 'Wow! This looks amazing. Adding to my bucket list!',
          timestamp: DateTime.now().subtract(const Duration(days: 28)),
        ),
        JourneyComment(
          id: 'comment_2',
          userId: 'user_3',
          userName: 'Amit Kumar',
          userAvatar: 'https://i.pravatar.cc/150?img=33',
          comment: 'Great photos! How was the houseboat experience?',
          timestamp: DateTime.now().subtract(const Duration(days: 27)),
        ),
      ],
      tags: ['Kerala', 'Backwaters', 'Nature', 'Houseboat'],
      isPublished: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      mapImageUrl: 'https://via.placeholder.com/600x300?text=Kerala+Map',
    ),
    Journey(
      id: 'journey_2',
      userId: 'user_3',
      user: users[2],
      title: 'Ladakh Adventure',
      destination: 'Ladakh',
      description: 'Epic bike trip through the Himalayas',
      coverPhotos: [
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
        'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?w=400',
      ],
      itinerary: [
        ItineraryDay(
          dayNumber: 1,
          title: 'Leh Acclimatization',
          description: 'Rested and explored Leh market',
          activities: ['Shanti Stupa', 'Leh Palace', 'Local market'],
          photos: [],
        ),
        ItineraryDay(
          dayNumber: 2,
          title: 'Nubra Valley',
          description: 'Crossed Khardung La pass',
          activities: ['Khardung La', 'Diskit Monastery', 'Camel safari'],
          photos: [],
        ),
      ],
      startDate: DateTime.now().subtract(const Duration(days: 45)),
      endDate: DateTime.now().subtract(const Duration(days: 38)),
      likesCount: 789,
      commentsCount: 56,
      comments: [],
      tags: ['Ladakh', 'Adventure', 'Biking', 'Mountains'],
      isPublished: true,
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
      mapImageUrl: 'https://via.placeholder.com/600x300?text=Ladakh+Map',
    ),
    Journey(
      id: 'journey_3',
      userId: 'user_2',
      user: users[1],
      title: 'Rajasthan Heritage Tour',
      destination: 'Rajasthan',
      description: 'Exploring the royal heritage of Rajasthan',
      coverPhotos: [
        'https://images.unsplash.com/photo-1599661046289-e021b409c04d?w=400',
      ],
      itinerary: [
        ItineraryDay(
          dayNumber: 1,
          title: 'Jaipur - The Pink City',
          description: 'Explored the magnificent forts',
          activities: ['Amber Fort', 'City Palace', 'Hawa Mahal'],
          photos: [],
        ),
      ],
      startDate: DateTime.now().subtract(const Duration(days: 60)),
      endDate: DateTime.now().subtract(const Duration(days: 55)),
      likesCount: 567,
      commentsCount: 43,
      comments: [],
      tags: ['Rajasthan', 'Heritage', 'Forts', 'Culture'],
      isPublished: true,
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      mapImageUrl: 'https://via.placeholder.com/600x300?text=Rajasthan+Map',
    ),
  ];

  // Mock notifications
  static final List<NotificationItem> notifications = [
    NotificationItem(
      id: 'notif_1',
      type: NotificationType.priceAlert,
      title: 'Price Drop Alert',
      message: 'Flight price dropped by ₹500 for Mumbai → Delhi',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      actionUrl: '/trip/flight_1',
    ),
    NotificationItem(
      id: 'notif_2',
      type: NotificationType.tracking,
      title: 'Waitlist Update',
      message: 'Your train moved to WL12 from WL14',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: false,
      actionUrl: '/tracking',
    ),
    NotificationItem(
      id: 'notif_3',
      type: NotificationType.social,
      title: 'New Journey Posted',
      message: 'Priya posted a new journey about Ooty',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
      actionUrl: '/journey/journey_1',
    ),
    NotificationItem(
      id: 'notif_4',
      type: NotificationType.deal,
      title: 'Limited Time Deal',
      message: 'Hotels in Goa 20% off today!',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
      isRead: true,
      actionUrl: '/deals',
    ),
    NotificationItem(
      id: 'notif_5',
      type: NotificationType.system,
      title: 'Verification Complete',
      message: 'Your traveler verification has been approved!',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
    ),
  ];

  // Mock daily insights
  static final List<DailyInsight> dailyInsights = [
    DailyInsight(
      id: 'insight_1',
      type: InsightType.waitlist,
      travelMode: TravelMode.train,
      title: 'Waitlist Moving',
      description: 'Your waitlist position improved',
      currentValue: 'WL 12',
      previousValue: 'WL 14',
      tripId: 'train_1',
      route: 'Mumbai → Delhi',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      isPositive: true,
      priceHistory: [],
    ),
    DailyInsight(
      id: 'insight_2',
      type: InsightType.price,
      travelMode: TravelMode.flight,
      title: 'Price Drop',
      description: 'Flight price decreased significantly',
      currentValue: '₹3999',
      previousValue: '₹4500',
      tripId: 'flight_1',
      route: 'Mumbai → Delhi',
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      isPositive: true,
      priceHistory: [
        PriceHistory(
          date: DateTime.now().subtract(const Duration(days: 7)),
          price: 5000,
        ),
        PriceHistory(
          date: DateTime.now().subtract(const Duration(days: 5)),
          price: 4800,
        ),
        PriceHistory(
          date: DateTime.now().subtract(const Duration(days: 3)),
          price: 4500,
        ),
        PriceHistory(
          date: DateTime.now().subtract(const Duration(days: 1)),
          price: 4200,
        ),
        PriceHistory(
          date: DateTime.now(),
          price: 3999,
        ),
      ],
    ),
    DailyInsight(
      id: 'insight_3',
      type: InsightType.seats,
      travelMode: TravelMode.bus,
      title: 'Limited Seats',
      description: 'Only few seats remaining',
      currentValue: '8 seats left',
      previousValue: '14 seats left',
      tripId: 'bus_1',
      route: 'Mumbai → Pune',
      timestamp: DateTime.now().subtract(const Duration(hours: 12)),
      isPositive: false,
    ),
  ];

  // Mock readiness score
  static ReadinessScore get readinessScore => ReadinessScore(
        score: 87,
        status: 'Excellent',
        factors: [
          'Best time to book',
          'Good weather forecast',
          'Low crowd levels',
          'Competitive prices',
        ],
        timestamp: DateTime.now(),
      );

  // Mock inspirations
  static final List<Inspiration> inspirations = [
    Inspiration(
      id: 'insp_1',
      destination: 'Manali',
      imageUrl: 'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?w=400',
      moodTags: ['Adventure', 'Mountains', 'Snow'],
      description: 'Experience the thrill of snow-covered peaks',
      bestTimeToVisit: 'October to February',
      estimatedBudget: 15000,
      durationDays: 4,
      highlights: ['Rohtang Pass', 'Solang Valley', 'Old Manali'],
      isDeal: true,
      dealDiscount: 20,
    ),
    Inspiration(
      id: 'insp_2',
      destination: 'Goa',
      imageUrl: 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=400',
      moodTags: ['Beach', 'Party', 'Relaxation'],
      description: 'Sun, sand, and endless beaches',
      bestTimeToVisit: 'November to February',
      estimatedBudget: 12000,
      durationDays: 5,
      highlights: ['Beaches', 'Water Sports', 'Nightlife', 'Portuguese Heritage'],
      isDeal: false,
    ),
    Inspiration(
      id: 'insp_3',
      destination: 'Ooty',
      imageUrl: 'https://images.unsplash.com/photo-1580056677515-8e7e72893e9c?w=400',
      moodTags: ['Nature', 'Peaceful', 'Hills'],
      description: 'Queen of Hill Stations',
      bestTimeToVisit: 'March to June',
      estimatedBudget: 10000,
      durationDays: 3,
      highlights: ['Tea Gardens', 'Botanical Garden', 'Ooty Lake'],
      isDeal: true,
      dealDiscount: 15,
    ),
    Inspiration(
      id: 'insp_4',
      destination: 'Jaipur',
      imageUrl: 'https://images.unsplash.com/photo-1599661046289-e021b409c04d?w=400',
      moodTags: ['Heritage', 'Culture', 'Royal'],
      description: 'The Pink City of India',
      bestTimeToVisit: 'October to March',
      estimatedBudget: 8000,
      durationDays: 3,
      highlights: ['Amber Fort', 'City Palace', 'Hawa Mahal', 'Local Markets'],
      isDeal: false,
    ),
    Inspiration(
      id: 'insp_5',
      destination: 'Andaman',
      imageUrl: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400',
      moodTags: ['Beach', 'Adventure', 'Exotic'],
      description: 'Tropical paradise with crystal clear waters',
      bestTimeToVisit: 'November to April',
      estimatedBudget: 25000,
      durationDays: 6,
      highlights: ['Radhanagar Beach', 'Scuba Diving', 'Ross Island'],
      isDeal: true,
      dealDiscount: 25,
    ),
  ];

  // Mock daily deals
  static final List<DailyDeal> dailyDeals = [
    DailyDeal(
      id: 'deal_1',
      title: 'Mumbai to Goa Flash Sale',
      description: 'Limited time offer on flights',
      imageUrl: 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=400',
      originalPrice: 4500,
      discountedPrice: 2499,
      discountPercentage: 45,
      validUntil: DateTime.now().add(const Duration(hours: 18)),
      destination: 'Goa',
      dealType: 'Flight',
    ),
    DailyDeal(
      id: 'deal_2',
      title: 'Weekend Getaway to Manali',
      description: 'Hotels + Activities package',
      imageUrl: 'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?w=400',
      originalPrice: 8000,
      discountedPrice: 5999,
      discountPercentage: 25,
      validUntil: DateTime.now().add(const Duration(days: 2)),
      destination: 'Manali',
      dealType: 'Package',
    ),
  ];

  // Mock quick actions for AI chat
  static final List<QuickAction> quickActions = [
    QuickAction(
      id: 'qa_1',
      label: 'Generate Itinerary',
      icon: '🗺️',
      prompt: 'Generate a 3-day itinerary for Goa',
    ),
    QuickAction(
      id: 'qa_2',
      label: 'Best Travel Option',
      icon: '✈️',
      prompt: 'What is the best way to travel from Mumbai to Delhi?',
    ),
    QuickAction(
      id: 'qa_3',
      label: 'Recommend Hotels',
      icon: '🏨',
      prompt: 'Recommend budget hotels in Bangalore',
    ),
    QuickAction(
      id: 'qa_4',
      label: 'Pack List',
      icon: '🎒',
      prompt: 'What should I pack for a trip to Ladakh?',
    ),
  ];

  // AI Response templates
  static Map<String, String> getAIResponse(String query) {
    final lowerQuery = query.toLowerCase();

    if (lowerQuery.contains('itinerary') || lowerQuery.contains('plan')) {
      return {
        'response': '''Here's a suggested 3-day itinerary:

**Day 1: Arrival & Beach Exploration**
- Morning: Arrive and check into hotel
- Afternoon: Visit Calangute Beach
- Evening: Explore Baga Beach nightlife

**Day 2: Culture & Heritage**
- Morning: Old Goa churches tour
- Afternoon: Fontainhas Latin Quarter
- Evening: Sunset cruise on Mandovi River

**Day 3: Adventure & Departure**
- Morning: Water sports at Candolim
- Afternoon: Shopping at Anjuna Flea Market
- Evening: Departure

Budget: ₹10,000-15,000 per person'''
      };
    } else if (lowerQuery.contains('hotel') || lowerQuery.contains('accommodation')) {
      return {
        'response': '''Here are my top hotel recommendations:

🏨 **Budget-Friendly:**
- Hotel Sunshine (₹2000/night) - Near Beach
- Cozy Inn (₹1500/night) - City Center

🏨 **Mid-Range:**
- Ocean View Resort (₹4500/night)
- Heritage Palace (₹3800/night)

🏨 **Luxury:**
- Taj Exotica (₹12000/night)
- Grand Oberoi (₹15000/night)

All include breakfast and WiFi!'''
      };
    } else if (lowerQuery.contains('travel') || lowerQuery.contains('best way')) {
      return {
        'response': '''Based on your requirements, here are the best options:

✈️ **Fastest: Flight**
- Duration: 2h 15m
- Price: ₹3,999
- Best for: Time-constrained travelers

🚆 **Most Comfortable: Train**
- Duration: 16h
- Price: ₹1,500
- Best for: Overnight journey

🚌 **Budget Option: Bus**
- Duration: 18h
- Price: ₹800
- Best for: Budget travelers

Recommendation: Flight if urgent, Train for comfort!'''
      };
    } else if (lowerQuery.contains('pack') || lowerQuery.contains('what should i')) {
      return {
        'response': '''Here's your packing checklist:

👕 **Clothing:**
- Warm layers (it gets cold!)
- Windproof jacket
- Comfortable trekking shoes
- Sunglasses

🎒 **Essentials:**
- Sunscreen (SPF 50+)
- Lip balm
- Water bottle
- First aid kit
- Altitude sickness medicine

📱 **Tech:**
- Power bank
- Camera
- Universal adapter

Stay hydrated and acclimate slowly!'''
      };
    } else {
      return {
        'response': '''I'd be happy to help! I can assist you with:

• Planning itineraries
• Finding best travel options
• Recommending hotels
• Packing tips
• Local attractions
• Budget planning

What would you like to know more about?'''
      };
    }
  }
}
