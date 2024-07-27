//
//  ProfileView.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    
                    ZStack {
                        
                        VStack {
                            
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.black)
                                .frame(width: 125, height: 125)
                                .padding()
                            
                            VStack (alignment: .center) {
                                HStack {
                                    Text("Name: ")
                                        .bold()
                                    Text(user.name)
                                }
                                .padding()
                                
                                HStack {
                                    Text("Email: ")
                                        .bold()
                                    Text(user.email)
                                }
                                .padding()
                                
                                HStack {
                                    Text("Member Since: ")
                                        .bold()
                                    Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                                }
                                .padding()
                                
                            }
                            .padding()
                            
                            Button {
                                viewModel.toggleEdit()
                            } label: {
                                Text("Edit Profile")
                                    .fontWeight(.bold)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            
                        }
                        if viewModel.canEdit {
                            VStack(spacing: 25) {
                                VStack{
                                    TextField(user.name, text: $viewModel.username)
                                        .textFieldStyle(DefaultTextFieldStyle())
                                        .autocapitalization(.none)
                                        .autocorrectionDisabled()
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                    
                                    
                                    TextField(user.email, text: $viewModel.email)
                                        .textFieldStyle(DefaultTextFieldStyle())
                                        .autocapitalization(.none)
                                        .autocorrectionDisabled()
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }
                                .padding()
                                
                                HStack {
                                    Button {
                                        viewModel.confirmEdit()
                                    } label: {
                                        Text("Confirm")
                                            .fontWeight(.bold)
                                            .padding()
                                            .foregroundColor(.black)
                                            .background(Color.white) // Change button background color
                                            .cornerRadius(10) // Round button corners
                                    }
                                    .frame(maxWidth: .infinity) // Make the button fill available space
                                    
                                    Button {
                                        viewModel.toggleEdit()
                                    } label: {
                                        Text("Cancel")
                                            .fontWeight(.bold)
                                            .padding()
                                            .foregroundColor(.black)
                                            .background(Color.white) // Change button background color
                                            .cornerRadius(10) // Round button corners
                                    }
                                    .frame(maxWidth: .infinity) // Make the button fill available space
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 280) // Adjust width as needed
                            .background(Color.black)
                            .cornerRadius(10) // Apply corner radius
                            .shadow(radius: 5) // Optional: Add shadow for better visibility
                            .padding(.top, 200)
                            .shadow(color: .red, radius: 5, x: 0, y: 2)
                        }
                    }
                } else {
                    Text("Loading Profile...")
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.logOut()
                    } label: {
                        Text("Log Out")
                            .fontWeight(.bold)
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }
            }
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
            }
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
}

#Preview {
    ProfileView()
}


