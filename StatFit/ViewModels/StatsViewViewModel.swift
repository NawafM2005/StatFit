//
//  StatsViewViewModel.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class StatsViewViewModel: ObservableObject {
    @Published var totalWorkouts = "0"
    @Published var mostUsedSplit = "None"
    @Published var daysDict: [String: String] = [:]
    @Published var percentageSplit: [String: String] = [:]
    
    init(){
    }
    
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
                self?.totalWorkouts = String(self?.daysDict.count ?? 0)
                self?.mostUsedSplit = self?.getMostUsedSplit() ?? "None"
                self?.percentageSplit = self?.getPercentageOfSplits() ?? [:]
            }
        }
    }
    
    func getMostUsedSplit() -> String? {
        // Dictionary to store the count of each split
        var tempDict = [String: Int]()
        
        // Iterate through daysDict
        for day in self.daysDict.keys {
            let split = self.daysDict[day] ?? "None"
            if let count = tempDict[split] {
                tempDict[split] = count + 1
            } else {
                tempDict[split] = 1
            }
        }
        
        // Find the most used split
        var mostUsedSplit: String? = nil
        var maxCount = 0
        
        for (split, count) in tempDict {
            if count > maxCount {
                maxCount = count
                mostUsedSplit = split
            }
        }
        
        return mostUsedSplit
    }
    
    func getPercentageOfSplits() -> [String: String] {
        // Dictionary to store the count of each split
        var tempDict = [String: Int]()
        
        // Iterate through daysDict
        for day in self.daysDict.keys {
            let split = self.daysDict[day] ?? "None"
            if let count = tempDict[split] {
                tempDict[split] = count + 1
            } else {
                tempDict[split] = 1
            }
        }
        
        var percentageDict: [String: String] = [:]
        
        let totalWorkouts = Int(self.totalWorkouts) ?? 0
        guard totalWorkouts > 0 else {
            return percentageDict
        }
        
        for (split, count) in tempDict {
            let percentage = (Double(count) / Double(totalWorkouts)) * 100
            percentageDict[split] = String(format: "%.0f", percentage) + "%"
        }
        
        // Sort the dictionary by key
        let sortedPercentageDict = percentageDict.sorted(by: { $0.key < $1.key })
        
        // Convert the sorted array back to a dictionary
        return Dictionary(uniqueKeysWithValues: sortedPercentageDict)
    }
}
