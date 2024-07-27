//
//  RegisterView.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-24.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Image("RegisterBg")
                    .resizable()
                    .ignoresSafeArea()
                    .blur(radius: 0.8)
                
                VStack(spacing: 50) {
                    
                    VStack {
                        Text("Register")
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: 50))
                            .shadow(color: .cyan, radius: 5, x: 0, y: 2)

                        
                        Text("Start your journey!")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .shadow(color: .black, radius: 5, x: 0, y: 2)
                    }
                    
                    // Centered Register Form
                    VStack {
                        Form {
                            VStack(spacing: 16) {
                                TextField("Username", text: $viewModel.username)
                                    .textFieldStyle(DefaultTextFieldStyle())
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                                    .padding()
                                
                                TextField("Email Address", text: $viewModel.email)
                                    .textFieldStyle(DefaultTextFieldStyle())
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                                    .padding()
                                
                                SecureField("Password", text: $viewModel.password)
                                    .textFieldStyle(DefaultTextFieldStyle())
                                    .padding()
                                
                                SecureField("Confirm Password", text: $viewModel.c_password)
                                    .textFieldStyle(DefaultTextFieldStyle())
                                    .padding()
                            }
                            
                            Button {
                                viewModel.register()
                            } label: {
                                Text("Sign Up")
                                    .fontWeight(.bold)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.black) // Change button background color
                                    .cornerRadius(10) // Round button corners
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center) // Center the button
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 450) // Adjust width as needed
                        .clipShape(RoundedRectangle(cornerRadius: 10)) // Round corners
                        .alert(isPresented: $viewModel.showErrorAlert) {
                            Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}

