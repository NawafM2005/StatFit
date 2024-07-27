//
//  HomeViewViewModel.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class HomeViewViewModel: ObservableObject {
    
    @Published var selectedDate = Date()
    @Published var daysDict: [String: String] = [:]
    @Published var selectedSplit = "None"
    
    func gatherData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.daysDict = data["daysDict"] as? [String: String] ?? [:]
                self?.updateSelectedSplit()
            }
        }
    }
    
    func saveSplit() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        // Convert selectedDate to a string using the dateFormatter
        let dateString = stringFromDate(selectedDate)
        
        // Create a dictionary with the updated data
        let updatedDict = [dateString: selectedSplit]
        
        // Fetch the current daysDict and update it
        db.collection("users").document(uid).getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            var existingDict = data["daysDict"] as? [String: String] ?? [:]
            existingDict.merge(updatedDict) { (_, new) in new } // Merge new data into existing
            
            // Update Firestore with the merged dictionary
            db.collection("users").document(uid).updateData(["daysDict": existingDict])
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    // Function to convert Date to String
    func stringFromDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    // Function to update selectedSplit based on selectedDate
    func updateSelectedSplit() {
        let dateString = stringFromDate(selectedDate)
        if let splitTitle = daysDict[dateString] {
            selectedSplit = splitTitle
        } else {
            selectedSplit = "None"
        }
    }
    
    func tommorowSplit() -> String {
        // Get tomorrow's date
        if let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) {
            // Convert tomorrow's date to a string
            let dateString = stringFromDate(tomorrowDate)
            
            // Update selectedSplit based on tomorrow's date
            if let splitTitle = daysDict[dateString] {
                return splitTitle
            } else {
                return "None"
            }
        }
        return "None"
    }
    
    func yesterdaySplit() -> String {
        // Get yesterdays date
        if let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) {
            // Convert yesterdays date to a string
            let dateString = stringFromDate(yesterdayDate)
            
            // Update selectedSplit based on yesterdays date
            if let splitTitle = daysDict[dateString] {
                return splitTitle
            } else {
                return "None"
            }
        }
        return "None"
    }
}
