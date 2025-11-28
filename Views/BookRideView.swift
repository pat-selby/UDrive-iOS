//
//  BookRideView.swift
//  UDrive
//
//  Created on 2024
//

import SwiftUI

struct BookRideView: View {
    @StateObject private var viewModel = BookRideViewModel()
    @EnvironmentObject var navigationService: NavigationService
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pickup Location")) {
                    TextField("Enter pickup address", text: $viewModel.pickupAddress)
                        .onChange(of: viewModel.pickupAddress) { newValue in
                            // In real app, this would geocode the address
                            if !newValue.isEmpty {
                                viewModel.setPickupLocation(
                                    Location(latitude: 37.7749, longitude: -122.4194, address: newValue)
                                )
                            }
                        }
                }
                
                Section(header: Text("Dropoff Location")) {
                    TextField("Enter dropoff address", text: $viewModel.dropoffAddress)
                        .onChange(of: viewModel.dropoffAddress) { newValue in
                            // In real app, this would geocode the address
                            if !newValue.isEmpty {
                                viewModel.setDropoffLocation(
                                    Location(latitude: 37.7849, longitude: -122.4094, address: newValue)
                                )
                            }
                        }
                }
                
                Section {
                    Toggle("Emergency Ride", isOn: $viewModel.isEmergency)
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                Section {
                    Button(action: {
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
                                Spacer()
                            }
                        } else {
                            Text("Book Ride")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .disabled(viewModel.isLoading || viewModel.pickupLocation == nil || viewModel.dropoffLocation == nil)
                }
            }
            .navigationTitle("Book a Ride")
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

