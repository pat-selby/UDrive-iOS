//
//  DriverDashboardView.swift
//  UDrive
//
//  Created on 2024
//

import SwiftUI

struct DriverDashboardView: View {
    @StateObject private var viewModel = DriverDashboardViewModel()
    @EnvironmentObject var navigationService: NavigationService
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Online Status Toggle
                    VStack(spacing: 12) {
                        Toggle(isOn: $viewModel.isOnline) {
                            Text("Go Online")
                                .font(.headline)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Active Rides
                    if !viewModel.activeRides.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Active Rides")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(viewModel.activeRides) { ride in
                                DriverRideCard(ride: ride) {
                                    navigationService.navigate(to: .trackShuttle)
                                }
                            }
                        }
                    }
                    
                    // Available Rides
                    if viewModel.isOnline && !viewModel.availableRides.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Available Rides")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(viewModel.availableRides) { ride in
                                AvailableRideCard(ride: ride) {
                                    viewModel.acceptRide(ride)
                                    viewModel.loadRides(for: UUID()) // In real app, use current driver ID
                                }
                            }
                        }
                    }
                    
                    if viewModel.isOnline && viewModel.availableRides.isEmpty {
                        Text("No available rides at the moment")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding()
                    }
                }
            }
            .navigationTitle("Driver Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        navigationService.logout()
                    }
                }
            }
            .onAppear {
                if let driverId = navigationService.currentUser?.id {
                    viewModel.loadRides(for: driverId)
                }
            }
        }
    }
}

struct DriverRideCard: View {
    let ride: Ride
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            onTap?()
        }) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(ride.status.rawValue.capitalized)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.green)
                        Text(ride.pickupLocation.address)
                            .font(.subheadline)
                    }
                    
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                        Text(ride.dropoffLocation.address)
                            .font(.subheadline)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal)
    }
}

struct AvailableRideCard: View {
    let ride: Ride
    var onAccept: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("New Request")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.green)
                    Text(ride.pickupLocation.address)
                        .font(.subheadline)
                }
                
                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                    Text(ride.dropoffLocation.address)
                        .font(.subheadline)
                }
            }
            
            Button(action: onAccept) {
                Text("Accept Ride")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

