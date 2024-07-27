//
//  SplitsView.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-24.
//

import SwiftUI
import FirebaseFirestoreSwift


struct SplitsView: View {
    @StateObject var viewModel: SplitsViewViewModel
    @FirestoreQuery var splits: [Split]
    
    
    init(userId: String){
        self._splits = FirestoreQuery(collectionPath: "users/\(userId)/splits")
        
        self._viewModel = StateObject(wrappedValue: SplitsViewViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack{
                if splits.isEmpty {
                    Text("No Workout Splits")
                        .padding(.top, 250)
                        .bold()
                        .foregroundColor(.red)
                }
                                
                List(splits) { split in
                    EachSplitView(split: split)
                        .swipeActions {
                            Button {
                                viewModel.delete(id: split.id)
                            } label: {
                                Text("Delete")
                            }
                            .tint(.red)
                        }
                        .padding(10)
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Workout Splits")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                }
                .frame(maxWidth: .infinity) // Make the button fill available space
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                AddSplitsView(newItemPresented: $viewModel.showingNewItemView)
            }
        }
    }
}

#Preview {
    SplitsView(userId: "RandomID")
}
