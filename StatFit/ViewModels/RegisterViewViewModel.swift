//
//  RegisterViewViewModel.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class RegisterViewViewModel: ObservableObject {
    init() {}
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var c_password = ""
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    
    func register(){
        if !validate() {
            showErrorAlert = true
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    self.errorMessage = "Please Try Again"
                    self.showErrorAlert = true
                }
                
                guard let userId = result?.user.uid else{
                    return
                }
                
                self.insertUserRecord(id: userId)
            }
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: username, email: email, joined: Date().timeIntervalSince1970, daysDict: [:])
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionairy())
        
        self.createSplit(userId: id)
        
    }
    
    func createSplit(userId: String) {
        
        let newId = UUID().uuidString
        
        let newItem = Split(title: "None", id: newId)
                                   
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("splits")
            .document(newId)
            .setData(newItem.asDictionairy())
        
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !username.trimmingCharacters(in: .whitespaces).isEmpty else{
                errorMessage = "Please Fill in all fields!"
                return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email!"
            return false
        }
        
        guard password.count >= 6 else{
            errorMessage = "Password must be more than 6 words!"
            return false
        }
        
        guard password == c_password else {
            errorMessage = "Passwords Must Match!"
            return false
        }
        
        return true
    }
}
