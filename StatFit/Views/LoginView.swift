//
//  LoginView.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Image("AppBg")
                    .resizable()
                    .ignoresSafeArea()
                    .blur(radius: 0.8)
                
                VStack(spacing: 100) {
                    
                    VStack {
                        Text("StatFit")
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: 50))
                            .shadow(color: .red, radius: 5, x: 0, y: 2) // Shadow for "StatFit"

                        
                        Text("Track your Workouts!")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .shadow(color: .black, radius: 5, x: 0, y: 2) // Shadow for "StatFit"
                    }
                    
                    // Centered Login Form
                    VStack {
                        Form {
                            VStack(spacing: 16) {
                                TextField("Email Address", text: $viewModel.email)
                                    .textFieldStyle(DefaultTextFieldStyle())
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                                    .padding()
                                
                                SecureField("Password", text: $viewModel.password)
                                    .textFieldStyle(DefaultTextFieldStyle())
                                    .padding()
                            }
                            
                            Button {
                                viewModel.login()
                            } label: {
                                Text("Log In")
                                    .fontWeight(.bold)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.black) // Change button background color
                                    .cornerRadius(10) // Round button corners
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center) // Center the button
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 320) // Adjust width as needed
                        .clipShape(RoundedRectangle(cornerRadius: 10)) // Round corners
                        .alert(isPresented: $viewModel.showErrorAlert) {
                            Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
                        }
                    }
                    
                    
                    // Create Account
                    VStack {
                        Text("Get your journey started!")
                            .foregroundColor(.white)
                            .bold()
                        
                        NavigationLink("Create an account", destination: RegisterView())
                            .foregroundColor(.blue)
                    }
                    .shadow(color: .cyan, radius: 15, x: 2, y: 0) // Shadow for "StatFit"
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
