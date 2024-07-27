//
//  StatFitApp.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-24.
//

import SwiftUI
import FirebaseCore


@main
struct StatFitApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
