import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../viewmodels/track_shuttle_viewmodel.dart';

class TrackShuttleMapScreen extends StatelessWidget {
  const TrackShuttleMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrackShuttleViewModel(),
      child: const TrackShuttleMapView(),
    );
  }
}

class TrackShuttleMapView extends StatelessWidget {
  const TrackShuttleMapView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TrackShuttleViewModel>(context);
    final navigationService = Provider.of<NavigationService>(context);

    // Mock ride for demo
    if (viewModel.ride == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel.loadMockRide();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Ride'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final user = navigationService.currentUser;
            if (user != null) {
              navigationService.navigate(
                user.userType.toString().contains('student')
                    ? AppScreen.studentDashboard
                    : AppScreen.driverDashboard,
              );
            }
          },
        ),
      ),
      body: Stack(
        children: [
          // Map placeholder - in real app, use google_maps_flutter
          Container(
            color: Colors.grey[200],
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Map View'),
                  Text('(Google Maps integration)'),
                ],
              ),
            ),
          ),
          if (viewModel.ride != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Ride Status: ${viewModel.ride!.status.toString().split('.').last}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (viewModel.ride!.isEmergency)
                            const Icon(Icons.warning, color: Colors.red),
                        ],
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.location_on, color: Colors.green),
                        title: Text(viewModel.ride!.pickupLocation.address),
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_on, color: Colors.red),
                        title: Text(viewModel.ride!.dropoffLocation.address),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

