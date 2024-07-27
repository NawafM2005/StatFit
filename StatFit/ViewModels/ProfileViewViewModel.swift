//
//  ProfileViewViewModel.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class ProfileViewViewModel : ObservableObject {
    init(){}
    
    @Published var user: User? = nil
    @Published var email = ""
    @Published var username = ""
    @Published var canEdit = false
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.user = User(id: data["id"] as? String ?? "",
                                  name: data["name"] as? String ?? "",
                                  email: data["email"] as? String ?? "",
                                  joined: data["joined"] as? TimeInterval ?? 0,
                                  daysDict: data["daysDict"] as? [Date: String] ?? [:])
            }
            
        }
    }
    
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    func confirmEdit() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let user = Auth.auth().currentUser else { return }
        
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        
        // Check for email existence first
        usersRef.whereField("email", isEqualTo: self.email).getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessage = "Something went wrong. Please try again later!"
                self.showErrorAlert = true
                return
            }
            
            if let snapshot = querySnapshot, !snapshot.isEmpty {
                self.errorMessage = "Email Already Exists"
                self.showErrorAlert = true
                return
            }
            
            var updates: [String: String] = [:]
            
            if !self.email.isEmpty {
                updates["email"] = self.email
            }
            
            if !self.username.isEmpty {
                updates["name"] = self.username
            }
            
            // Only update if there's something to change
            if !updates.isEmpty {
                let db = Firestore.firestore()
                db.collection("users").document(uid).updateData(updates)
                
                if let newEmail = updates["email"] {
                    user.sendEmailVerification(beforeUpdatingEmail: newEmail)
                }
            }  else {
                self.errorMessage = "Please Input a Change!"
                self.showErrorAlert = true
            }
            
            self.email = ""
            self.username = ""
            self.toggleEdit()
            self.fetchUser()
        }
    }
    
    func toggleEdit() {
        self.canEdit = !self.canEdit
    }
    
}
