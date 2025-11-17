import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/app_provider.dart';
import '../models/hotel.dart';
import '../widgets/custom_widgets.dart';

/// Hotel suggestion screen
class HotelSuggestionScreen extends StatefulWidget {
  final String destination;

  const HotelSuggestionScreen({super.key, required this.destination});

  @override
  State<HotelSuggestionScreen> createState() => _HotelSuggestionScreenState();
}

class _HotelSuggestionScreenState extends State<HotelSuggestionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppProvider>().loadHotels(destination: widget.destination);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels in ${widget.destination}'),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const LoadingIndicator(message: 'Finding best hotels...');
          }

          if (provider.hotels.isEmpty) {
            return EmptyState(
              message: 'No hotels found in ${widget.destination}',
              icon: Icons.hotel_outlined,
              actionText: 'Go Back',
              onAction: () => Navigator.pop(context),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.hotels.length,
            itemBuilder: (context, index) {
              final hotel = provider.hotels[index];
              return _HotelCard(hotel: hotel);
            },
          );
        },
      ),
    );
  }
}

class _HotelCard extends StatelessWidget {
  final Hotel hotel;

  const _HotelCard({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hotel Image
          AppImage(
            imageUrl: hotel.imageUrl,
            height: 180,
            width: double.infinity,
            borderRadius: 12,
          ),
          const SizedBox(height: 12),

          // Hotel Name & Rating
          Row(
            children: [
              Expanded(
                child: Text(
                  hotel.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              RatingStars(rating: hotel.rating, size: 18),
              const SizedBox(width: 4),
              Text('(${hotel.reviewCount})'),
            ],
          ),
          const SizedBox(height: 8),

          // Location
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  hotel.distanceString,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Amenities
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: hotel.amenities.take(4).map((amenity) {
              return Chip(
                label: Text(amenity),
                visualDensity: VisualDensity.compact,
              );
            }).toList(),
          ),
          const SizedBox(height: 12),

          // Price & Tags
          Row(
            children: [
              PriceTag(price: hotel.price),
              const Text('/night'),
              const Spacer(),
              if (hotel.freeCancellation)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Free Cancellation',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),

          // Price Trend Chart
          if (hotel.priceHistory.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Price Trend',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 80,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: hotel.priceHistory
                          .asMap()
                          .entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value.price))
                          .toList(),
                      isCurved: true,
                      color: hotel.priceTrend == 'down'
                          ? Colors.green
                          : hotel.priceTrend == 'up'
                              ? Colors.red
                              : Colors.blue,
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: (hotel.priceTrend == 'down'
                                ? Colors.green
                                : hotel.priceTrend == 'up'
                                    ? Colors.red
                                    : Colors.blue)
                            .withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: 12),

          // Book Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Booking ${hotel.name} (Mock)')),
                );
              },
              child: const Text('Book Now'),
            ),
          ),
        ],
      ),
    );
  }
}
