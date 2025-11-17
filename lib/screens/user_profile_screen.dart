import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/custom_widgets.dart';
import 'verification_screen.dart';

/// User profile screen
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AppProvider>(
          builder: (context, provider, _) {
            final user = provider.currentUser;
            if (user == null) {
              return const Center(child: Text('Please log in'));
            }

            final userJourneys = provider.journeys
                .where((j) => j.userId == user.id)
                .toList();

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {},
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Transform.translate(
                    offset: const Offset(0, -50),
                    child: Column(
                      children: [
                        // Avatar
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: user.avatarUrl != null
                                  ? NetworkImage(user.avatarUrl!)
                                  : null,
                              child: user.avatarUrl == null
                                  ? Text(
                                      user.name[0],
                                      style: const TextStyle(fontSize: 40),
                                    )
                                  : null,
                            ),
                            if (user.isVerified)
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: VerifiedBadge(size: 32),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Name
                        Text(
                          user.name,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),

                        // Email
                        Text(
                          user.email,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(height: 8),

                        // Bio
                        if (user.bio != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              user.bio!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        const SizedBox(height: 16),

                        // Stats
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _StatItem(label: 'Journeys', count: user.journeyCount),
                            const SizedBox(width: 32),
                            _StatItem(label: 'Followers', count: user.followersCount),
                            const SizedBox(width: 32),
                            _StatItem(label: 'Following', count: user.followingCount),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Verification Button
                        if (!user.isVerified)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const VerificationScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.verified_user),
                              label: const Text('Become Verified Traveler'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 48),
                              ),
                            ),
                          ),
                        const SizedBox(height: 24),

                        // My Journeys
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Text(
                                'My Journeys',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        if (userJourneys.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(32),
                            child: EmptyState(
                              message: 'No journeys yet',
                              icon: Icons.map_outlined,
                            ),
                          )
                        else
                          ...userJourneys.map((journey) {
                            return AppCard(
                              child: Row(
                                children: [
                                  if (journey.coverPhotos.isNotEmpty)
                                    AppImage(
                                      imageUrl: journey.coverPhotos[0],
                                      width: 80,
                                      height: 80,
                                      borderRadius: 12,
                                    ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          journey.title,
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(
                                          journey.destination,
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(Icons.favorite, size: 16),
                                            Text(' ${journey.likesCount}'),
                                            const SizedBox(width: 16),
                                            const Icon(Icons.comment, size: 16),
                                            Text(' ${journey.commentsCount}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final int count;

  const _StatItem({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }
}
