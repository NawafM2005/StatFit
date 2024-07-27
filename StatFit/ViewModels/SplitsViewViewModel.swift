//
//  SplitsViewViewModel.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-24.
//

import Foundation
import FirebaseFirestore

class SplitsViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    
    private let userId: String
    
    init(userId: String){
        self.userId = userId
    }
    
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("splits")
            .document(id)
            .delete()
    }
}
