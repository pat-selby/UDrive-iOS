import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../viewmodels/student_dashboard_viewmodel.dart';
import '../utils/animations.dart';

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
    final user = navigationService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              navigationService.logout();
            },
          ),
        ],
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
        child: RefreshIndicator(
          onRefresh: () async {
            if (navigationService.currentUser != null) {
              viewModel.loadRides(navigationService.currentUser!.id);
            }
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Welcome Header
              SlideInAnimation(
                begin: const Offset(0, -0.2),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF000000), Color(0xFF1a1a1a)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFD700).withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFFFFD700),
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome back!',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              user?.name ?? 'Student',
                              style: const TextStyle(
                                color: Color(0xFFFFD700),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'GSU',
                          style: TextStyle(
                            color: Color(0xFFFFD700),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Quick Actions
              FadeInAnimation(
                duration: const Duration(milliseconds: 400),
                child: const Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ScaleAnimation(
                      child: _ActionCard(
                        icon: Icons.directions_car,
                        label: 'Book Ride',
                        color: const Color(0xFF000000),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF000000), Color(0xFF1a1a1a)],
                        ),
                        onTap: () {
                          navigationService.navigate(AppScreen.bookRide);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ScaleAnimation(
                      duration: const Duration(milliseconds: 500),
                      child: _ActionCard(
                        icon: Icons.warning,
                        label: 'Emergency',
                        color: Colors.red,
                        gradient: LinearGradient(
                          colors: [Colors.red[600]!, Colors.red[800]!],
                        ),
                        onTap: () {
                          navigationService.navigate(AppScreen.emergencyRide);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              if (viewModel.activeRides.isNotEmpty) ...[
                const SizedBox(height: 24),
                FadeInAnimation(
                  child: const Text(
                    'Active Rides',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ...viewModel.activeRides.asMap().entries.map((entry) {
                  return SlideInAnimation(
                    begin: const Offset(0.2, 0),
                    duration: Duration(milliseconds: 400 + (entry.key * 100)),
                    child: _RideCard(ride: entry.value),
                  );
                }),
              ],
              if (viewModel.recentRides.isNotEmpty) ...[
                const SizedBox(height: 24),
                FadeInAnimation(
                  child: const Text(
                    'Recent Rides',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ...viewModel.recentRides.asMap().entries.map((entry) {
                  return SlideInAnimation(
                    begin: const Offset(0.2, 0),
                    duration: Duration(milliseconds: 400 + (entry.key * 100)),
                    child: _RideCard(ride: entry.value),
                  );
                }),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Gradient gradient;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RideCard extends StatelessWidget {
  final dynamic ride;

  const _RideCard({required this.ride});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF000000).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.directions_car,
            color: Color(0xFF000000),
          ),
        ),
        title: Text(
          'Ride to ${ride.dropoffLocation.address}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('From ${ride.pickupLocation.address}'),
        trailing: ride.isEmergency
            ? const Icon(Icons.warning, color: Colors.red)
            : const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
