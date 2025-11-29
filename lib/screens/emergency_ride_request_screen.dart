import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../viewmodels/book_ride_viewmodel.dart';

class EmergencyRideRequestScreen extends StatelessWidget {
  const EmergencyRideRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookRideViewModel()..isEmergency = true,
      child: const EmergencyRideRequestView(),
    );
  }
}

class EmergencyRideRequestView extends StatelessWidget {
  const EmergencyRideRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BookRideViewModel>(context);
    final navigationService = Provider.of<NavigationService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            navigationService.navigate(AppScreen.studentDashboard);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Icon(Icons.warning, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Emergency Ride Request',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Your request will be prioritized and sent to nearby drivers immediately',
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Form(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Pickup Location',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      onChanged: (value) {
                        viewModel.setPickupAddress(value);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Dropoff Location',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      onChanged: (value) {
                        viewModel.setDropoffAddress(value);
                      },
                    ),
                    if (viewModel.errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        viewModel.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: viewModel.isLoading
                      ? null
                      : () {
                          viewModel.bookRide().then((ride) {
                            if (ride != null) {
                              navigationService.navigate(AppScreen.studentDashboard);
                            }
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: viewModel.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.warning),
                            SizedBox(width: 8),
                            Text(
                              'Request Emergency Ride',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

