import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../viewmodels/book_ride_viewmodel.dart';

class BookRideScreen extends StatelessWidget {
  const BookRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookRideViewModel(),
      child: const BookRideView(),
    );
  }
}

class BookRideView extends StatelessWidget {
  const BookRideView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BookRideViewModel>(context);
    final navigationService = Provider.of<NavigationService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Ride'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            navigationService.navigate(AppScreen.studentDashboard);
          },
        ),
      ),
      body: Form(
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
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Emergency Ride'),
              value: viewModel.isEmergency,
              onChanged: (value) {
                viewModel.isEmergency = value;
              },
            ),
            if (viewModel.errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                viewModel.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
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
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: viewModel.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Book Ride'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

