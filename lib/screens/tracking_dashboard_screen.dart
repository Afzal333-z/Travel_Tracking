import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/app_provider.dart';
import '../models/daily_insight.dart';
import '../widgets/custom_widgets.dart';

/// Tracking dashboard screen
class TrackingDashboardScreen extends StatefulWidget {
  const TrackingDashboardScreen({super.key});

  @override
  State<TrackingDashboardScreen> createState() => _TrackingDashboardScreenState();
}

class _TrackingDashboardScreenState extends State<TrackingDashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppProvider>().loadDailyInsights();
    });
  }

  Future<void> _refresh() async {
    await context.read<AppProvider>().refreshInsights();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insights refreshed!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: Consumer<AppProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const LoadingIndicator(message: 'Loading insights...');
              }

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    title: const Text('Travel Tracking'),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: _refresh,
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Readiness Score
                        if (provider.readinessScore != null)
                          _ReadinessScoreCard(score: provider.readinessScore!),

                        // Daily Insights
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Today\'s Insights',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),

                        if (provider.dailyInsights.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(24),
                            child: EmptyState(
                              message: 'No tracking data yet',
                              icon: Icons.track_changes,
                            ),
                          )
                        else
                          ...provider.dailyInsights.map((insight) {
                            return _InsightCard(insight: insight);
                          }).toList(),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ReadinessScoreCard extends StatelessWidget {
  final ReadinessScore score;

  const _ReadinessScoreCard({required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            'Travel Readiness Score',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: score.score / 100,
                  strokeWidth: 12,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${score.score}',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        score.status,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...score.factors.map((factor) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      factor,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final DailyInsight insight;

  const _InsightCard({required this.insight});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: insight.isPositive
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  insight.type.icon,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      insight.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      insight.route,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ),
              Text(
                insight.travelMode.icon,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(insight.description),
          const SizedBox(height: 12),
          Row(
            children: [
              if (insight.previousValue != null)
                Text(
                  '${insight.previousValue} ${insight.changeIndicator}',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
              const SizedBox(width: 8),
              Text(
                insight.currentValue,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: insight.isPositive ? Colors.green : Colors.orange,
                    ),
              ),
            ],
          ),
          if (insight.priceHistory != null && insight.priceHistory!.isNotEmpty) ...[
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: insight.priceHistory!
                          .asMap()
                          .entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value.price))
                          .toList(),
                      isCurved: true,
                      color: Theme.of(context).colorScheme.primary,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
