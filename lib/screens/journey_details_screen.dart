import 'package:flutter/material.dart';
import '../models/journey.dart';
import '../widgets/custom_widgets.dart';

/// Journey details screen
class JourneyDetailsScreen extends StatelessWidget {
  final Journey journey;

  const JourneyDetailsScreen({super.key, required this.journey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Cover Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(journey.title),
              background: journey.coverPhotos.isNotEmpty
                  ? AppImage(
                      imageUrl: journey.coverPhotos[0],
                      fit: BoxFit.cover,
                    )
                  : Container(color: Colors.grey),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Info
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: journey.user.avatarUrl != null
                            ? NetworkImage(journey.user.avatarUrl!)
                            : null,
                        child: journey.user.avatarUrl == null
                            ? Text(journey.user.name[0])
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  journey.user.name,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                if (journey.user.isVerified) ...[
                                  const SizedBox(width: 4),
                                  const VerifiedBadge(size: 16),
                                ],
                              ],
                            ),
                            Text(
                              '${journey.durationDays} days in ${journey.destination}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.person_add, size: 16),
                        label: const Text('Follow'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    journey.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),

                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: journey.tags.map((tag) {
                      return Chip(label: Text(tag));
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Stats
                  Row(
                    children: [
                      _StatItem(icon: Icons.favorite, count: journey.likesCount),
                      const SizedBox(width: 24),
                      _StatItem(icon: Icons.comment, count: journey.commentsCount),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Itinerary
                  Text(
                    'Day-by-Day Itinerary',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  ...journey.itinerary.map((day) {
                    return _DayCard(day: day);
                  }).toList(),

                  const SizedBox(height: 24),

                  // Map (Mock)
                  if (journey.mapImageUrl != null) ...[
                    Text(
                      'Route Map',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    AppImage(
                      imageUrl: journey.mapImageUrl!,
                      height: 200,
                      width: double.infinity,
                      borderRadius: 12,
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Comments
                  Text(
                    'Comments',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  if (journey.comments.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text('No comments yet'),
                      ),
                    )
                  else
                    ...journey.comments.map((comment) {
                      return _CommentCard(comment: comment);
                    }).toList(),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.comment),
        label: const Text('Add Comment'),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final int count;

  const _StatItem({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 4),
        Text(
          '$count',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}

class _DayCard extends StatelessWidget {
  final ItineraryDay day;

  const _DayCard({required this.day});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Day ${day.dayNumber}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            day.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(day.description),
          if (day.activities.isNotEmpty) ...[
            const SizedBox(height: 12),
            ...day.activities.map((activity) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(child: Text(activity)),
                  ],
                ),
              );
            }).toList(),
          ],
          if (day.photos.isNotEmpty) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: day.photos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AppImage(
                      imageUrl: day.photos[index],
                      width: 150,
                      borderRadius: 8,
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CommentCard extends StatelessWidget {
  final JourneyComment comment;

  const _CommentCard({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(comment.userAvatar),
            radius: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.userName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _timeAgo(comment.timestamp),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(comment.comment),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _timeAgo(DateTime timestamp) {
    final difference = DateTime.now().difference(timestamp);
    if (difference.inDays > 0) return '${difference.inDays}d ago';
    if (difference.inHours > 0) return '${difference.inHours}h ago';
    if (difference.inMinutes > 0) return '${difference.inMinutes}m ago';
    return 'Just now';
  }
}
