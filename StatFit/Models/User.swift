//
//  User.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-24.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email : String
    let joined: TimeInterval
    let daysDict: [Date: String]
}
