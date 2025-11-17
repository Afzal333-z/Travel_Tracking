import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/journey.dart';
import '../widgets/custom_widgets.dart';
import 'journey_details_screen.dart';
import 'create_journey_screen.dart';

/// Journey feed screen showing user travel stories
class JourneyFeedScreen extends StatefulWidget {
  const JourneyFeedScreen({super.key});

  @override
  State<JourneyFeedScreen> createState() => _JourneyFeedScreenState();
}

class _JourneyFeedScreenState extends State<JourneyFeedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppProvider>().loadJourneys();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AppProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const LoadingIndicator(message: 'Loading journeys...');
            }

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  title: const Text('Travel Journeys'),
                ),
                if (provider.journeys.isEmpty)
                  SliverFillRemaining(
                    child: EmptyState(
                      message: 'No journeys yet',
                      icon: Icons.map_outlined,
                      actionText: 'Create Journey',
                      onAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CreateJourneyScreen(),
                          ),
                        );
                      },
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final journey = provider.journeys[index];
                        return _JourneyCard(journey: journey);
                      },
                      childCount: provider.journeys.length,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateJourneyScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Create Journey'),
      ),
    );
  }
}

class _JourneyCard extends StatelessWidget {
  final Journey journey;

  const _JourneyCard({required this.journey});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => JourneyDetailsScreen(journey: journey),
          ),
        );
      },
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
                      '${journey.durationDays} days • ${journey.destination}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            journey.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            journey.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),

          // Cover Photos
          if (journey.coverPhotos.isNotEmpty)
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: journey.coverPhotos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Hero(
                      tag: '${journey.id}_$index',
                      child: AppImage(
                        imageUrl: journey.coverPhotos[index],
                        width: 300,
                        borderRadius: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 12),

          // Tags
          Wrap(
            spacing: 8,
            children: journey.tags.map((tag) {
              return Chip(
                label: Text(tag),
                visualDensity: VisualDensity.compact,
              );
            }).toList(),
          ),
          const SizedBox(height: 12),

          // Actions
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  context.read<AppProvider>().likeJourney(journey.id);
                },
              ),
              Text('${journey.likesCount}'),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.comment_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => JourneyDetailsScreen(journey: journey),
                    ),
                  );
                },
              ),
              Text('${journey.commentsCount}'),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share functionality coming soon')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
