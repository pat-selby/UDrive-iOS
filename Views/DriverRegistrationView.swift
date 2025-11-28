//
//  DriverRegistrationView.swift
//  UDrive
//
//  Created on 2024
//

import SwiftUI
import UIKit

struct DriverRegistrationView: View {
    @StateObject private var viewModel = DriverRegistrationViewModel()
    @EnvironmentObject var navigationService: NavigationService
    @State private var showDriverPhotoPicker = false
    @State private var showVehiclePhotoPicker = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Full Name", text: $viewModel.name)
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    TextField("Phone Number", text: $viewModel.phoneNumber)
                        .keyboardType(.phonePad)
                    TextField("Driver's License Number", text: $viewModel.licenseNumber)
                }
                
                Section(header: Text("Vehicle Information")) {
                    TextField("Make", text: $viewModel.vehicleMake)
                    TextField("Model", text: $viewModel.vehicleModel)
                    TextField("Year", text: $viewModel.vehicleYear)
                        .keyboardType(.numberPad)
                    TextField("Color", text: $viewModel.vehicleColor)
                    TextField("License Plate", text: $viewModel.licensePlate)
                    TextField("Capacity", text: $viewModel.vehicleCapacity)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Photos")) {
                    Button(action: {
                        showDriverPhotoPicker = true
                    }) {
                        HStack {
                            Text("Driver Photo")
                            Spacer()
                            if viewModel.driverPhoto != nil {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "camera.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    
                    Button(action: {
                        showVehiclePhotoPicker = true
                    }) {
                        HStack {
                            Text("Vehicle Photo")
                            Spacer()
                            if viewModel.vehiclePhoto != nil {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "camera.fill")
                                    .foregroundColor(.blue)
                            }
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
                
                Section {
                    Button(action: {
                        viewModel.registerDriver { success in
                            if success {
                                navigationService.navigate(to: .driverDashboard)
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
                            Text("Register as Driver")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .disabled(viewModel.isLoading)
                }
            }
            .navigationTitle("Driver Registration")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        navigationService.navigate(to: .signupChoice)
                    }
                }
            }
            .sheet(isPresented: $showDriverPhotoPicker) {
                ImagePicker(image: $viewModel.driverPhoto)
            }
            .sheet(isPresented: $showVehiclePhotoPicker) {
                ImagePicker(image: $viewModel.vehiclePhoto)
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

