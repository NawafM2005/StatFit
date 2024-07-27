//
//  AddSplitsViewViewModel.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AddSplitsViewModel : ObservableObject {
    
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false

    
    init(){}
    
    func save() {
        guard canSave else {
            return
        }
        
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let newId = UUID().uuidString
        
        let newItem = Split(title: title, id: newId)
                                   
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("splits")
            .document(newId)
            .setData(newItem.asDictionairy())
        
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
    }
}


