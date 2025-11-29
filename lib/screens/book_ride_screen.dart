import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../viewmodels/book_ride_viewmodel.dart';
import '../services/mock_data_service.dart';
import '../utils/animations.dart';

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

class BookRideView extends StatefulWidget {
  const BookRideView({super.key});

  @override
  State<BookRideView> createState() => _BookRideViewState();
}

class _BookRideViewState extends State<BookRideView> {
  String? _selectedPickup;
  String? _selectedDropoff;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BookRideViewModel>(context);
    final navigationService = Provider.of<NavigationService>(context);
    final campusLocations = MockDataService.getGSUCampusLocations();

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[50]!,
              Colors.white,
            ],
          ),
        ),
        child: Form(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // GSU Header
              SlideInAnimation(
                begin: const Offset(0, -0.2),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF000000), Color(0xFF1a1a1a)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.school,
                        color: Color(0xFFFFD700),
                        size: 30,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'GSU Campus Rides',
                          style: TextStyle(
                            color: Color(0xFFFFD700),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Pickup Location
              FadeInAnimation(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pickup Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_on, color: Colors.green),
                        labelText: 'Select pickup location',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      value: _selectedPickup,
                      items: campusLocations.map((location) {
                        return DropdownMenuItem(
                          value: location.address,
                          child: Text(location.address),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPickup = value;
                        });
                        if (value != null) {
                          final location = campusLocations.firstWhere(
                            (loc) => loc.address == value,
                          );
                          viewModel.setPickupAddress(location.address);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Dropoff Location
              FadeInAnimation(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dropoff Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_on, color: Colors.red),
                        labelText: 'Select dropoff location',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      value: _selectedDropoff,
                      items: campusLocations.map((location) {
                        return DropdownMenuItem(
                          value: location.address,
                          child: Text(location.address),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDropoff = value;
                        });
                        if (value != null) {
                          final location = campusLocations.firstWhere(
                            (loc) => loc.address == value,
                          );
                          viewModel.setDropoffAddress(location.address);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Emergency Toggle
              ScaleAnimation(
                child: Card(
                  child: SwitchListTile(
                    title: const Text(
                      'Emergency Ride',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('Priority ride for urgent situations'),
                    value: viewModel.isEmergency,
                    onChanged: (value) {
                      viewModel.isEmergency = value;
                    },
                    activeColor: Colors.red,
                  ),
                ),
              ),
              if (viewModel.errorMessage != null) ...[
                const SizedBox(height: 16),
                ScaleAnimation(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red[700]),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            viewModel.errorMessage!,
                            style: TextStyle(color: Colors.red[700]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              // Book Ride Button
              ScaleAnimation(
                duration: const Duration(milliseconds: 500),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: viewModel.isLoading
                        ? null
                        : () {
                            viewModel.bookRide().then((ride) {
                              if (ride != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Ride requested! A GSU driver will be notified.'),
                                    backgroundColor: Color(0xFF000000),
                                  ),
                                );
                                navigationService.navigate(AppScreen.studentDashboard);
                              }
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: viewModel.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFFFD700),
                              ),
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.directions_car),
                              SizedBox(width: 8),
                              Text(
                                'Book GSU Ride',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
