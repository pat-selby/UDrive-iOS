import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../viewmodels/driver_dashboard_viewmodel.dart';

class DriverDashboardScreen extends StatelessWidget {
  const DriverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DriverDashboardViewModel()
        ..loadRides(Provider.of<NavigationService>(context, listen: false).currentUser?.id ?? ''),
      child: const DriverDashboardView(),
    );
  }
}

class DriverDashboardView extends StatelessWidget {
  const DriverDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DriverDashboardViewModel>(context);
    final navigationService = Provider.of<NavigationService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              navigationService.logout();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: SwitchListTile(
              title: const Text('Go Online'),
              value: viewModel.isOnline,
              onChanged: (value) {
                viewModel.toggleOnlineStatus();
              },
            ),
          ),
          if (viewModel.activeRides.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text(
              'Active Rides',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...viewModel.activeRides.map((ride) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.directions_car),
                    title: Text('To ${ride.dropoffLocation.address}'),
                    subtitle: Text('From ${ride.pickupLocation.address}'),
                  ),
                )),
          ],
          if (viewModel.isOnline && viewModel.availableRides.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text(
              'Available Rides',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...viewModel.availableRides.map((ride) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.new_releases, color: Colors.orange),
                        title: Text('To ${ride.dropoffLocation.address}'),
                        subtitle: Text('From ${ride.pickupLocation.address}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              viewModel.acceptRide(ride);
                            },
                            child: const Text('Accept Ride'),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
          if (viewModel.isOnline && viewModel.availableRides.isEmpty) ...[
            const SizedBox(height: 16),
            const Center(
              child: Text('No available rides at the moment'),
            ),
          ],
        ],
      ),
    );
  }
}

