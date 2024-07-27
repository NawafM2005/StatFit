//
//  EachSplitView.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-25.
//

import SwiftUI

struct EachSplitView: View {
    let split: Split
    @StateObject var viewModel = EachSplitViewViewModel()
    
    var body: some View {
        Text(split.title)
            .font(.body)
    }
}

#Preview {
    EachSplitView(split: .init(title: "PUSH", id: "123"))
}
