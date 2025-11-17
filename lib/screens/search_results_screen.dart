import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/trip_option.dart';
import '../widgets/custom_widgets.dart';
import 'trip_details_screen.dart';

/// Search results screen
class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const LoadingIndicator(message: 'Searching...');
          }

          if (provider.searchResults.isEmpty) {
            return EmptyState(
              message: 'No results found',
              icon: Icons.search_off,
              actionText: 'Go Back',
              onAction: () => Navigator.pop(context),
            );
          }

          return Column(
            children: [
              // Sort Options
              Container(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _SortChip(
                        label: 'Price (Low)',
                        onTap: () => provider.sortSearchResults('price_low'),
                      ),
                      _SortChip(
                        label: 'Price (High)',
                        onTap: () => provider.sortSearchResults('price_high'),
                      ),
                      _SortChip(
                        label: 'Duration',
                        onTap: () => provider.sortSearchResults('duration'),
                      ),
                      _SortChip(
                        label: 'Rating',
                        onTap: () => provider.sortSearchResults('rating'),
                      ),
                    ],
                  ),
                ),
              ),

              // Results List
              Expanded(
                child: ListView.builder(
                  itemCount: provider.searchResults.length,
                  itemBuilder: (context, index) {
                    final trip = provider.searchResults[index];
                    return _TripCard(trip: trip);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Filters',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            const Text('Filter options coming soon...'),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Apply',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  final TripOption trip;

  const _TripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TripDetailsScreen(trip: trip),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(trip.mode.icon, style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.providerName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Row(
                      children: [
                        RatingStars(rating: trip.rating),
                        const SizedBox(width: 8),
                        Text(
                          '(${trip.reviewCount})',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PriceTag(price: trip.price),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.departureTime.toString().split(' ')[1].substring(0, 5),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(trip.from, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.arrow_forward, size: 20),
                  Text(trip.durationString),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    trip.arrivalTime.toString().split(' ')[1].substring(0, 5),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(trip.to, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              Chip(
                label: Text(trip.availability),
                visualDensity: VisualDensity.compact,
              ),
              if (trip.isRefundable)
                const Chip(
                  label: Text('Refundable'),
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SortChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(label),
        onPressed: onTap,
      ),
    );
  }
}
