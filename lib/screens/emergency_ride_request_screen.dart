import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../viewmodels/book_ride_viewmodel.dart';
import '../services/mock_data_service.dart';
import '../utils/animations.dart';

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

class EmergencyRideRequestView extends StatefulWidget {
  const EmergencyRideRequestView({super.key});

  @override
  State<EmergencyRideRequestView> createState() => _EmergencyRideRequestViewState();
}

class _EmergencyRideRequestViewState extends State<EmergencyRideRequestView> {
  String? _selectedPickup;
  String? _selectedDropoff;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BookRideViewModel>(context);
    final navigationService = Provider.of<NavigationService>(context);
    final campusLocations = MockDataService.getGSUCampusLocations();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Ride'),
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
              Colors.red[50]!,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Emergency Header
              BounceAnimation(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red[600]!, Colors.red[800]!],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.warning, size: 60, color: Colors.white),
                      SizedBox(height: 16),
                      Text(
                        'Emergency Ride Request',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'GSU Safety Priority',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange[700]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Your request will be prioritized and sent to nearby GSU drivers immediately',
                          style: TextStyle(
                            color: Colors.orange[900],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Form(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Pickup Location
                      FadeInAnimation(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Current Location',
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
                                labelText: 'Select your location',
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
                              'Destination',
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
                                labelText: 'Select destination',
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
              // Emergency Button
              Padding(
                padding: const EdgeInsets.all(16),
                child: ScaleAnimation(
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
                                      content: Text('Emergency ride requested! GSU security and drivers notified.'),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                  navigationService.navigate(AppScreen.studentDashboard);
                                }
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
