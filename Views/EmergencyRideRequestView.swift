//
//  EmergencyRideRequestView.swift
//  UDrive
//
//  Created on 2024
//

import SwiftUI

struct EmergencyRideRequestView: View {
    @StateObject private var viewModel = BookRideViewModel()
    @EnvironmentObject var navigationService: NavigationService
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Spacer()
                
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.red)
                    
                    Text("Emergency Ride Request")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Your request will be prioritized and sent to nearby drivers immediately")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                Form {
                    Section(header: Text("Pickup Location")) {
                        TextField("Current location or enter address", text: $viewModel.pickupAddress)
                            .onChange(of: viewModel.pickupAddress) { newValue in
                                if !newValue.isEmpty {
                                    viewModel.setPickupLocation(
                                        Location(latitude: 37.7749, longitude: -122.4194, address: newValue)
                                    )
                                }
                            }
                    }
                    
                    Section(header: Text("Dropoff Location")) {
                        TextField("Enter destination", text: $viewModel.dropoffAddress)
                            .onChange(of: viewModel.dropoffAddress) { newValue in
                                if !newValue.isEmpty {
                                    viewModel.setDropoffLocation(
                                        Location(latitude: 37.7849, longitude: -122.4094, address: newValue)
                                    )
                                }
                            }
                    }
                    
                    if let errorMessage = viewModel.errorMessage {
                        Section {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                }
                .frame(height: 300)
                
                Button(action: {
                    viewModel.isEmergency = true
                    viewModel.bookRide { ride in
                        if ride != nil {
                            navigationService.navigate(to: .studentDashboard)
                        }
                    }
                }) {
                    if viewModel.isLoading {
                        HStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            Spacer()
                        }
                        .padding()
                    } else {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                            Text("Request Emergency Ride")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                }
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(12)
                .disabled(viewModel.isLoading || viewModel.pickupLocation == nil || viewModel.dropoffLocation == nil)
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Emergency")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        navigationService.navigate(to: .studentDashboard)
                    }
                }
            }
        }
    }
}

