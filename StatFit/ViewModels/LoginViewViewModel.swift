//
//  LoginViewViewModel.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-24.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    
    
    init(){}
    
    func login(){
        
        if !validate() {
            // If validation fails, show the alert
            showErrorAlert = true
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    self.errorMessage = "Wrong Credentials Please Try Again!"
                    self.showErrorAlert = true
                }
            }
        }
    }
    
    private func validate() -> Bool{
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            errorMessage = "Please fill in all Fields!"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email!"
            return false
        }
        
        return true
    }
}
