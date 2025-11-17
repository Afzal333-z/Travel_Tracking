# TravelMate: Smart Travel Assistant & Journey Sharing

A comprehensive Flutter mobile application for travel planning, tracking, and journey sharing with AI assistance.

## Features

### 1. Travel Search (Frontend-Only)
- Search for flights, trains, buses, and hotels
- Filter and sort results by price, duration, and rating
- View detailed trip information
- Mock booking functionality

### 2. Daily Tracking Dashboard
- Track train waitlist progress
- Monitor flight price changes
- View bus seat availability
- Hotel price drop alerts
- Daily Travel Readiness Score (0-100)
- Interactive price history charts

### 3. AI Travel Assistant
- Chat-style interface with AI responses
- Quick action buttons for common queries
- Pre-written responses for:
  - Itinerary generation
  - Travel recommendations
  - Hotel suggestions
  - Packing lists

### 4. Travel Inspiration Feed
- Swipeable destination cards
- Daily deals and flash sales
- Mood-based tag filtering
- Trending destinations
- Discount badges

### 5. User Travel Journeys (Social/UGC)
- View community travel stories
- Create and publish your own journeys
- Day-by-day itinerary builder
- Photo galleries
- Comments and likes
- Verified traveler badges

### 6. Create Journey
- Add journey title and description
- Set travel dates
- Build day-wise itineraries
- Simulated photo upload
- Publish to community

### 7. User Profile & Verification
- View profile statistics
- Journey history
- Verification system:
  - Upload government ID
  - Upload travel ticket
  - Instant mock approval

### 8. Hotel Suggestions
- Browse hotels by destination
- View ratings and reviews
- Price trend charts
- Filter by amenities
- Distance from city center
- Free cancellation tags

### 9. Notifications Center
- Price drop alerts
- Tracking updates
- Social notifications
- Deal announcements
- Unread badges

### 10. Bottom Navigation
- Home (Inspiration Feed)
- Search
- Tracking
- Journeys
- Profile

## Project Structure

```
lib/
├── models/              # Data models
│   ├── user.dart
│   ├── trip_option.dart
│   ├── journey.dart
│   ├── hotel.dart
│   ├── notification_item.dart
│   ├── daily_insight.dart
│   ├── message.dart
│   └── inspiration.dart
│
├── mock_data/           # Mock/dummy data
│   └── mock_data.dart
│
├── services/            # Mock services
│   ├── mock_search_service.dart
│   ├── mock_tracking_service.dart
│   ├── mock_journey_service.dart
│   ├── mock_user_service.dart
│   ├── mock_hotel_service.dart
│   ├── mock_notification_service.dart
│   ├── mock_inspiration_service.dart
│   └── mock_ai_chat_service.dart
│
├── providers/           # State management
│   └── app_provider.dart
│
├── screens/             # UI screens
│   ├── home_screen.dart
│   ├── inspiration_feed_screen.dart
│   ├── search_screen.dart
│   ├── search_results_screen.dart
│   ├── trip_details_screen.dart
│   ├── tracking_dashboard_screen.dart
│   ├── journey_feed_screen.dart
│   ├── journey_details_screen.dart
│   ├── create_journey_screen.dart
│   ├── user_profile_screen.dart
│   ├── verification_screen.dart
│   ├── hotel_suggestion_screen.dart
│   ├── notification_center_screen.dart
│   └── ai_chat_assistant_screen.dart
│
├── widgets/             # Reusable components
│   └── custom_widgets.dart
│
├── themes/              # Theme configuration
│   └── app_theme.dart
│
├── utils/               # Utilities
│   └── app_routes.dart
│
└── main.dart            # App entry point
```

## Technologies Used

- **Flutter 3.x**: UI framework
- **Dart**: Programming language
- **Provider**: State management
- **Material 3**: Design system
- **Google Fonts**: Typography
- **fl_chart**: Charts and graphs
- **intl**: Internationalization and formatting
- **uuid**: Unique ID generation

## Installation & Setup

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Steps

1. **Clone the repository**
   ```bash
   cd Travel_Tracking
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Architecture

### Clean Architecture
The app follows clean architecture principles with clear separation of concerns:

- **Models**: Plain Dart classes representing data entities
- **Services**: Mock services that simulate backend API calls
- **Providers**: State management using Provider pattern
- **Screens**: UI components organized by feature
- **Widgets**: Reusable UI components

### State Management
Uses **Provider** for reactive state management:
- Single `AppProvider` manages all app state
- Consumers listen to state changes
- Efficient rebuilds with granular listeners

### Data Flow
1. User interacts with UI
2. UI calls provider methods
3. Provider calls service methods
4. Services return mock data
5. Provider updates state
6. UI rebuilds with new data

## Key Features Explained

### Mock Data System
All data is stored locally in `mock_data/mock_data.dart`:
- No backend required
- Instant responses
- Fully functional UI
- Easy to modify test data

### Theme System
Supports light and dark themes:
- Material 3 design
- Google Fonts (Poppins)
- Consistent color scheme
- Automatic system theme detection

### Navigation
Simple named route navigation:
- Bottom tab navigation for main screens
- Push navigation for details
- Modal sheets for filters/dialogs

## Screen Details

### Home Screen (Inspiration Feed)
- Daily deals carousel
- AI assistant quick access
- Travel inspiration grid
- Notification badge

### Search Screen
- Travel mode selection (Flight/Train/Bus/Hotel)
- From/To fields
- Date picker
- Quick route shortcuts

### Tracking Dashboard
- Travel Readiness Score with circular progress
- Daily insights cards
- Price history charts
- Refresh functionality

### Journey Feed
- Social feed of user journeys
- User verification badges
- Photo carousels
- Like and comment counts

### AI Chat
- Chat interface with bubbles
- Quick action chips
- Smart responses based on keywords
- Message history

## Mock Services

All services simulate network delays and return realistic data:

- **Search Service**: Returns filtered trip options
- **Tracking Service**: Provides daily insights and readiness scores
- **Journey Service**: Manages user travel stories
- **Hotel Service**: Returns hotel suggestions with pricing
- **Notification Service**: Manages app notifications
- **AI Chat Service**: Generates contextual responses

## Customization

### Adding Mock Data
Edit `lib/mock_data/mock_data.dart` to add:
- New trips
- Hotels
- Journeys
- Inspirations
- Notifications

### Changing Theme Colors
Edit `lib/themes/app_theme.dart`:
```dart
static const primaryLight = Color(0xFF2E7D32);
static const secondaryLight = Color(0xFFFF6F00);
```

### Adding New Screens
1. Create screen in `lib/screens/`
2. Add route in `lib/utils/app_routes.dart`
3. Update navigation calls

## Testing

### Manual Testing
1. Run the app
2. Navigate through all screens
3. Test all interactions
4. Verify mock data displays correctly

### Test Scenarios
- Search for trips with different modes
- Create a journey with multiple days
- Track trips in dashboard
- Chat with AI assistant
- Verify user profile
- Book hotels
- View notifications

## Future Enhancements

Potential additions for backend integration:
- Real API integration
- User authentication
- Real-time notifications
- Image upload functionality
- Payment gateway
- Social features (followers, comments)
- Analytics integration

## Known Limitations

- No actual backend integration
- No real data persistence (resets on restart)
- Image uploads are simulated
- No actual booking functionality
- Limited to mock data scenarios

## Contributing

To contribute:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This is a demonstration project. Use as needed for educational purposes.

## Contact

For questions or feedback about this project, please create an issue in the repository.

---

**Built with ❤️ using Flutter**
