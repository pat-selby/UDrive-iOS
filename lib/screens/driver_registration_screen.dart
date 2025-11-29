import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../viewmodels/driver_registration_viewmodel.dart';

class DriverRegistrationScreen extends StatelessWidget {
  const DriverRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DriverRegistrationViewModel(),
      child: const DriverRegistrationView(),
    );
  }
}

class DriverRegistrationView extends StatelessWidget {
  const DriverRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DriverRegistrationViewModel>(context);
    final navigationService = Provider.of<NavigationService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Registration'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            navigationService.navigate(AppScreen.signupChoice);
          },
        ),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => viewModel.name = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => viewModel.email = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) => viewModel.phoneNumber = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Driver\'s License Number',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => viewModel.licenseNumber = value,
            ),
            const SizedBox(height: 24),
            const Text(
              'Vehicle Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Make',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => viewModel.vehicleMake = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Model',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => viewModel.vehicleModel = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Year',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => viewModel.vehicleYear = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Color',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => viewModel.vehicleColor = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'License Plate',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => viewModel.licensePlate = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Capacity',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => viewModel.vehicleCapacity = value,
            ),
            const SizedBox(height: 24),
            const Text(
              'Photos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              title: const Text('Driver Photo'),
              trailing: viewModel.driverPhoto != null
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.camera_alt),
              onTap: () {
                // In real app, use image_picker
                viewModel.driverPhoto = 'mock_photo';
              },
            ),
            ListTile(
              title: const Text('Vehicle Photo'),
              trailing: viewModel.vehiclePhoto != null
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.camera_alt),
              onTap: () {
                // In real app, use image_picker
                viewModel.vehiclePhoto = 'mock_photo';
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
                        viewModel.registerDriver().then((success) {
                          if (success) {
                            navigationService.navigate(AppScreen.driverDashboard);
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
                    : const Text('Register as Driver'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

