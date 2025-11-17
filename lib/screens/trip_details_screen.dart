import 'package:flutter/material.dart';
import '../models/trip_option.dart';
import '../widgets/custom_widgets.dart';
import 'hotel_suggestion_screen.dart';

/// Trip details screen
class TripDetailsScreen extends StatelessWidget {
  final TripOption trip;

  const TripDetailsScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Provider Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                children: [
                  Text(
                    trip.mode.icon,
                    style: const TextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    trip.providerName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingStars(rating: trip.rating, size: 20),
                      const SizedBox(width: 8),
                      Text('${trip.reviewCount} reviews'),
                    ],
                  ),
                ],
              ),
            ),

            // Route Details
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          trip.departureTime.toString().split(' ')[1].substring(0, 5),
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(trip.from),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(Icons.arrow_forward, size: 32),
                      Text(trip.durationString),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          trip.arrivalTime.toString().split(' ')[1].substring(0, 5),
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(trip.to),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: PriceTag(price: trip.price),
              ),
            ),
            const SizedBox(height: 24),

            // Amenities
            if (trip.amenities.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Amenities',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: trip.amenities.map((amenity) {
                    return Chip(label: Text(amenity));
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Additional Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppCard(
                child: Column(
                  children: [
                    _InfoRow(label: 'Availability', value: trip.availability),
                    const Divider(),
                    _InfoRow(
                      label: 'Refundable',
                      value: trip.isRefundable ? 'Yes' : 'No',
                    ),
                    if (trip.seatType != null) ...[
                      const Divider(),
                      _InfoRow(label: 'Seat Type', value: trip.seatType!),
                    ],
                    if (trip.flightClass != null) ...[
                      const Divider(),
                      _InfoRow(label: 'Class', value: trip.flightClass!),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Book Now Button
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CustomButton(
                    text: 'Book Now',
                    icon: Icons.confirmation_number,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Booking confirmed! (Mock)')),
                      );
                      // Show hotel suggestions after booking
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HotelSuggestionScreen(destination: trip.to),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to tracking!')),
                      );
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text('Track This Trip'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
