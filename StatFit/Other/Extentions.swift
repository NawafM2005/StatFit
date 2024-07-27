//
//  Extentions.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-24.
//

import Foundation
import UIKit

extension Encodable {
    func asDictionairy() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else{
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}

extension UITabBar {
    static func setCustomAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black // Set your desired color here
        
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
}

