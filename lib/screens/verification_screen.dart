import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/custom_widgets.dart';

/// Verification screen for becoming a verified traveler
class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String? _idProofPath;
  String? _ticketPath;
  bool _isSubmitting = false;

  void _pickIDProof() {
    // Simulate file picker
    setState(() {
      _idProofPath = 'mock_id_proof.jpg';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ID Proof selected (Mock)')),
    );
  }

  void _pickTicket() {
    // Simulate file picker
    setState(() {
      _ticketPath = 'mock_ticket.jpg';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ticket selected (Mock)')),
    );
  }

  Future<void> _submit() async {
    if (_idProofPath == null || _ticketPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload both documents')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final success = await context.read<AppProvider>().verifyUser(
          idProofPath: _idProofPath!,
          ticketPath: _ticketPath!,
        );

    if (mounted) {
      setState(() => _isSubmitting = false);
      if (success) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.green, size: 32),
                SizedBox(width: 12),
                Text('Verified!'),
              ],
            ),
            content: const Text(
              'Congratulations! You are now a verified traveler.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Great!'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Verified'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.verified_user,
                        size: 48,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Become a Verified Traveler',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Verified travelers get:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...[
                    'Verified badge on profile',
                    'Higher visibility for journeys',
                    'Priority support',
                    'Exclusive deals and offers',
                  ].map((benefit) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.check, color: Colors.green, size: 20),
                          const SizedBox(width: 8),
                          Expanded(child: Text(benefit)),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Upload Section
            Text(
              'Required Documents',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // ID Proof Upload
            _UploadCard(
              title: 'Government ID Proof',
              description: 'Upload Aadhaar, PAN, Passport, or Driver\'s License',
              icon: Icons.badge_outlined,
              isUploaded: _idProofPath != null,
              onTap: _pickIDProof,
            ),
            const SizedBox(height: 16),

            // Ticket Upload
            _UploadCard(
              title: 'Travel Ticket (Masked)',
              description: 'Upload any recent travel ticket with PNR masked',
              icon: Icons.confirmation_number_outlined,
              isUploaded: _ticketPath != null,
              onTap: _pickTicket,
            ),
            const SizedBox(height: 32),

            // Submit Button
            CustomButton(
              text: 'Submit for Verification',
              icon: Icons.send,
              isLoading: _isSubmitting,
              onPressed: _submit,
            ),
            const SizedBox(height: 16),

            // Privacy Notice
            Text(
              'Your documents are safe and will be processed securely. We respect your privacy.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UploadCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isUploaded;
  final VoidCallback onTap;

  const _UploadCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isUploaded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUploaded
                  ? Colors.green.withOpacity(0.1)
                  : Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isUploaded ? Icons.check_circle : icon,
              size: 32,
              color: isUploaded ? Colors.green : Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  isUploaded ? 'Uploaded ✓' : description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isUploaded ? Colors.green : Colors.grey,
                      ),
                ),
              ],
            ),
          ),
          Icon(
            isUploaded ? Icons.edit : Icons.upload_file,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
