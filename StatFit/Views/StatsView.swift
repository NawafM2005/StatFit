//
//  StatsView.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-26.
//

import SwiftUI

struct StatsView: View {
    
    @StateObject var viewModel = StatsViewViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Text("Total Workouts: ")
                        .bold()
                    Text(viewModel.totalWorkouts)
                }
                .padding()
                
                HStack {
                    Text("Most Used Split: ")
                        .bold()
                    Text(viewModel.mostUsedSplit)
                }
                .padding()
                
                
                Text("↓ Percentage of Compleation ↓")
                    .bold()
                    .foregroundColor(.red)
                
                ForEach(viewModel.percentageSplit.sorted(by: { $0.key < $1.key }), id: \.key) { (key, value) in
                    HStack {
                        Text("\(key): ")
                            .bold()
                        Text(value)
                    }
                    .padding()
                }
            }
            .padding()
            .navigationTitle("Stats")
            .onAppear {
                viewModel.gatherData()
            }
        }
    }
}

#Preview {
    StatsView()
}
