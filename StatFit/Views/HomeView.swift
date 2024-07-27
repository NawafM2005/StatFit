//
//  HomeView.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-24.
//

import SwiftUI
import FirebaseFirestoreSwift

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewViewModel()
    @FirestoreQuery var splits: [Split]
    
    
    init(userId: String){
        self._splits = FirestoreQuery(collectionPath: "users/\(userId)/splits")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "Select Date",
                    selection: $viewModel.selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 5)
                        .background(.pink)
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                .onChange(of: viewModel.selectedDate) { _ in
                    viewModel.updateSelectedSplit()
                    viewModel.gatherData()
                }
                
                
                HStack {
                    Text("Todays Split:")
                        .bold()
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    
                    Menu {
                        ForEach(splits) { split in
                            Button{
                                viewModel.selectedSplit = split.title
                                viewModel.saveSplit()
                            } label : {
                                Text(split.title)
                            }
                        }
                    } label: {
                        Text(viewModel.selectedSplit)
                            .bold()
                            .font(.system(size: 16))
                            .padding()
                            .background(Color.blue.opacity(0.6))
                            .cornerRadius(8)
                    }
                }
                
                HStack {
                    Text("Tommorows Split: \(viewModel.tommorowSplit())")
                        .bold()
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                }
                .padding(.top, 10)
                
                HStack {
                    Text("Yesterdays Split: \(viewModel.yesterdaySplit())")
                        .bold()
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .onAppear {
                viewModel.gatherData()
                viewModel.updateSelectedSplit()
            }
            .navigationTitle("Home")
        }
    }
}



#Preview {
    HomeView(userId: "RandomID")
}
