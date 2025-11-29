import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../viewmodels/student_dashboard_viewmodel.dart';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudentDashboardViewModel()
        ..loadRides(Provider.of<NavigationService>(context, listen: false).currentUser?.id ?? ''),
      child: const StudentDashboardView(),
    );
  }
}

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StudentDashboardViewModel>(context);
    final navigationService = Provider.of<NavigationService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              navigationService.logout();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (navigationService.currentUser != null) {
            viewModel.loadRides(navigationService.currentUser!.id);
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _ActionCard(
                    icon: Icons.directions_car,
                    label: 'Book Ride',
                    color: Colors.blue,
                    onTap: () {
                      navigationService.navigate(AppScreen.bookRide);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ActionCard(
                    icon: Icons.warning,
                    label: 'Emergency',
                    color: Colors.red,
                    onTap: () {
                      navigationService.navigate(AppScreen.emergencyRide);
                    },
                  ),
                ),
              ],
            ),
            if (viewModel.activeRides.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'Active Rides',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...viewModel.activeRides.map((ride) => _RideCard(ride: ride)),
            ],
            if (viewModel.recentRides.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'Recent Rides',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...viewModel.recentRides.map((ride) => _RideCard(ride: ride)),
            ],
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

class _RideCard extends StatelessWidget {
  final dynamic ride; // Using dynamic for simplicity

  const _RideCard({required this.ride});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.directions_car),
        title: Text('Ride to ${ride.dropoffLocation.address}'),
        subtitle: Text('From ${ride.pickupLocation.address}'),
        trailing: ride.isEmergency
            ? const Icon(Icons.warning, color: Colors.red)
            : null,
      ),
    );
  }
}

