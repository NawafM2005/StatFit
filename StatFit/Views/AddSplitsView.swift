//
//  addSplitView.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-25.
//

import SwiftUI

struct AddSplitsView: View {
    
    @Binding var newItemPresented: Bool
    @StateObject var viewModel = AddSplitsViewModel()
    
    var body: some View {
        VStack {
            Text("New Split")
                .bold()
                .font(.system(size: 32))
                .padding()
                .foregroundColor(.white)
            
            Form {
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                Button {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                    }
                    else {
                        viewModel.showAlert = true
                    }
                    
                } label: {
                    Text("Save")
                }
                
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all required fields!"))
            }
        }
        .background(.black)
    }
}

#Preview {
    AddSplitsView(newItemPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }))
}

