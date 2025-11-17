import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/app_provider.dart';
import '../models/journey.dart';
import '../widgets/custom_widgets.dart';

/// Create journey screen
class CreateJourneyScreen extends StatefulWidget {
  const CreateJourneyScreen({super.key});

  @override
  State<CreateJourneyScreen> createState() => _CreateJourneyScreenState();
}

class _CreateJourneyScreenState extends State<CreateJourneyScreen> {
  final _titleController = TextEditingController();
  final _destinationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<ItineraryDay> _itinerary = [];
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 3));

  @override
  void dispose() {
    _titleController.dispose();
    _destinationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addItineraryDay() {
    showDialog(
      context: context,
      builder: (context) {
        final titleController = TextEditingController();
        final descController = TextEditingController();
        return AlertDialog(
          title: Text('Day ${_itinerary.length + 1}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  setState(() {
                    _itinerary.add(ItineraryDay(
                      dayNumber: _itinerary.length + 1,
                      title: titleController.text,
                      description: descController.text,
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _publish() async {
    if (_titleController.text.isEmpty ||
        _destinationController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final provider = context.read<AppProvider>();
    final journey = Journey(
      id: const Uuid().v4(),
      userId: provider.currentUser!.id,
      user: provider.currentUser!,
      title: _titleController.text,
      destination: _destinationController.text,
      description: _descriptionController.text,
      itinerary: _itinerary,
      startDate: _startDate,
      endDate: _endDate,
      createdAt: DateTime.now(),
      coverPhotos: [
        'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=400',
      ],
    );

    final success = await provider.createJourney(journey);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Journey published successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Journey'),
        actions: [
          Consumer<AppProvider>(
            builder: (context, provider, _) {
              return TextButton(
                onPressed: provider.isLoading ? null : _publish,
                child: const Text('Publish'),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Journey Title *',
                hintText: 'e.g., Amazing Kerala Trip',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                labelText: 'Destination *',
                hintText: 'e.g., Kerala',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description *',
                hintText: 'Tell us about your journey...',
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 24),

            // Dates
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() => _startDate = date);
                      }
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Start Date'),
                      child: Text('${_startDate.day}/${_startDate.month}/${_startDate.year}'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _endDate,
                        firstDate: _startDate,
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() => _endDate = date);
                      }
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'End Date'),
                      child: Text('${_endDate.day}/${_endDate.month}/${_endDate.year}'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Itinerary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Day-by-Day Itinerary',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton.icon(
                  onPressed: _addItineraryDay,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Day'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (_itinerary.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('No itinerary added yet'),
                ),
              )
            else
              ..._itinerary.map((day) {
                return AppCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Day ${day.dayNumber}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Text(
                              day.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            if (day.description.isNotEmpty) Text(day.description),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            _itinerary.remove(day);
                            // Renumber days
                            for (int i = 0; i < _itinerary.length; i++) {
                              _itinerary[i] = ItineraryDay(
                                dayNumber: i + 1,
                                title: _itinerary[i].title,
                                description: _itinerary[i].description,
                                activities: _itinerary[i].activities,
                                photos: _itinerary[i].photos,
                              );
                            }
                          });
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),

            const SizedBox(height: 32),

            // Mock photo upload
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Photo upload simulated')),
                );
              },
              icon: const Icon(Icons.add_photo_alternate),
              label: const Text('Add Photos'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
