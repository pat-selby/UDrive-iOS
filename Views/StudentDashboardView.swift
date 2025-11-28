//
//  StudentDashboardView.swift
//  UDrive
//
//  Created on 2024
//

import SwiftUI

struct StudentDashboardView: View {
    @StateObject private var viewModel = StudentDashboardViewModel()
    @EnvironmentObject var navigationService: NavigationService
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Quick Actions
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Quick Actions")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        HStack(spacing: 12) {
                            Button(action: {
                                navigationService.navigate(to: .bookRide)
                            }) {
                                VStack(spacing: 8) {
                                    Image(systemName: "car.fill")
                                        .font(.title)
                                    Text("Book Ride")
                                        .font(.caption)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(12)
                            }
                            
                            Button(action: {
                                navigationService.navigate(to: .emergencyRide)
                            }) {
                                VStack(spacing: 8) {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .font(.title)
                                    Text("Emergency")
                                        .font(.caption)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.1))
                                .foregroundColor(.red)
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                    
                    // Active Rides
                    if !viewModel.activeRides.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Active Rides")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(viewModel.activeRides) { ride in
                                RideCard(ride: ride) {
                                    navigationService.navigate(to: .trackShuttle)
                                }
                            }
                        }
                    }
                    
                    // Recent Rides
                    if !viewModel.recentRides.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Recent Rides")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(viewModel.recentRides) { ride in
                                RideCard(ride: ride)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Student Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        navigationService.logout()
                    }
                }
            }
            .onAppear {
                if let userId = navigationService.currentUser?.id {
                    viewModel.loadRides(for: userId)
                }
            }
        }
    }
}

struct RideCard: View {
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
                        .background(ride.isEmergency ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                    Spacer()
                    
                    if ride.isEmergency {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                    }
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

