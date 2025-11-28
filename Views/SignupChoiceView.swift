//
//  SignupChoiceView.swift
//  UDrive
//
//  Created on 2024
//

import SwiftUI

struct SignupChoiceView: View {
    @EnvironmentObject var navigationService: NavigationService
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()
                
                Text("Choose Your Account Type")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 20) {
                    Button(action: {
                        navigationService.navigate(to: .driverRegistration)
                    }) {
                        VStack(spacing: 16) {
                            Image(systemName: "car.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                            
                            Text("Driver")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Text("Provide rides to students")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                        .background(Color.blue)
                        .cornerRadius(16)
                    }
                    
                    Button(action: {
                        let viewModel = SignupViewModel()
                        viewModel.selectedUserType = .student
                        navigationService.navigate(to: .studentDashboard)
                    }) {
                        VStack(spacing: 16) {
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                            
                            Text("Student")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Text("Request rides from drivers")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                        .background(Color.green)
                        .cornerRadius(16)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        navigationService.navigate(to: .login)
                    }
                }
            }
        }
    }
}

