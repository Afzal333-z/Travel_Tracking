import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/trip_option.dart';
import '../widgets/custom_widgets.dart';
import 'search_results_screen.dart';

/// Travel search screen
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 7));
  TravelMode _selectedMode = TravelMode.flight;

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  Future<void> _search() async {
    if (_fromController.text.isEmpty || _toController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter from and to locations')),
      );
      return;
    }

    await context.read<AppProvider>().searchTrips(
          from: _fromController.text,
          to: _toController.text,
          date: _selectedDate,
          mode: _selectedMode,
        );

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SearchResultsScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search Travels',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),

              // Travel Mode Selection
              Text(
                'Travel Mode',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: TravelMode.values.map((mode) {
                  final isSelected = _selectedMode == mode;
                  return ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(mode.icon),
                        const SizedBox(width: 8),
                        Text(mode.displayName),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedMode = mode;
                        });
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // From Field
              TextField(
                controller: _fromController,
                decoration: InputDecoration(
                  labelText: 'From',
                  hintText: 'Enter departure city',
                  prefixIcon: const Icon(Icons.location_on_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // To Field
              TextField(
                controller: _toController,
                decoration: InputDecoration(
                  labelText: 'To',
                  hintText: 'Enter destination city',
                  prefixIcon: const Icon(Icons.location_on),
                ),
              ),
              const SizedBox(height: 16),

              // Date Field
              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Date',
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Search Button
              Consumer<AppProvider>(
                builder: (context, provider, _) {
                  return CustomButton(
                    text: 'Search',
                    icon: Icons.search,
                    isLoading: provider.isLoading,
                    onPressed: _search,
                  );
                },
              ),

              const SizedBox(height: 32),

              // Quick Actions
              Text(
                'Popular Routes',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              _QuickRouteCard(
                from: 'Mumbai',
                to: 'Delhi',
                icon: '✈️',
                onTap: () {
                  _fromController.text = 'Mumbai';
                  _toController.text = 'Delhi';
                },
              ),
              _QuickRouteCard(
                from: 'Bangalore',
                to: 'Goa',
                icon: '🏖️',
                onTap: () {
                  _fromController.text = 'Bangalore';
                  _toController.text = 'Goa';
                },
              ),
              _QuickRouteCard(
                from: 'Delhi',
                to: 'Manali',
                icon: '⛰️',
                onTap: () {
                  _fromController.text = 'Delhi';
                  _toController.text = 'Manali';
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickRouteCard extends StatelessWidget {
  final String from;
  final String to;
  final String icon;
  final VoidCallback onTap;

  const _QuickRouteCard({
    required this.from,
    required this.to,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$from → $to',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  'Tap to use this route',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}
